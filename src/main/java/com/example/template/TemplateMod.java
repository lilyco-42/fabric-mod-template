package com.example.template;

import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.event.lifecycle.v1.ClientTickEvents;
import net.fabricmc.fabric.api.client.keybinding.v1.KeyBindingHelper;
import net.minecraft.client.option.KeyBinding;
import net.minecraft.client.util.InputUtil;
import net.minecraft.text.Text;
import org.lwjgl.glfw.GLFW;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * {{MOD_NAME}} — {{DESCRIPTION}}
 *
 * <p>This is a template mod. Replace the placeholder values and
 * add your own logic.
 *
 * <p>Built-in features:
 * <ul>
 *   <li>Toggle keybinding with action-bar feedback</li>
 *   <li>SLF4J logging via {@link #LOGGER}</li>
 *   <li>Chinese + English language files</li>
 * </ul>
 */
public class TemplateMod implements ClientModInitializer {

    /** Unique mod identifier. Must match {@code fabric.mod.json}. */
    public static final String MOD_ID = "template-mod";

    /** Logger — messages appear in {@code logs/latest.log}. */
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    /** Whether the mod feature is currently active. */
    private static boolean enabled = true;

    /** The toggle keybinding reference. */
    private static KeyBinding toggleKey;

    /**
     * Called by Fabric when the client starts.
     * Register keybindings, event listeners, and render callbacks here.
     */
    @Override
    public void onInitializeClient() {
        LOGGER.info("[Template] Initializing...");

        // Register a toggle keybinding (default: V)
        toggleKey = KeyBindingHelper.registerKeyBinding(new KeyBinding(
                "key.template-mod.toggle",          // translation key
                InputUtil.Type.KEYSYM,
                GLFW.GLFW_KEY_V,                    // default key
                "category.template-mod"             // category in Controls screen
        ));

        // Listen for key presses each tick
        ClientTickEvents.END_CLIENT_TICK.register(client -> {
            while (toggleKey.wasPressed()) {
                enabled = !enabled;
                if (client.player != null) {
                    client.player.sendMessage(
                            Text.literal("§6[Template] "
                                    + (enabled ? "§a✔ ON" : "§c✘ OFF")),
                            true // show on action bar
                    );
                }
                LOGGER.info("[Template] Toggled → {}", enabled ? "ON" : "OFF");
            }
        });

        LOGGER.info("[Template] Ready! Press V to toggle.");
    }

    // ---------- public API ----------

    public static boolean isEnabled() {
        return enabled;
    }
}
