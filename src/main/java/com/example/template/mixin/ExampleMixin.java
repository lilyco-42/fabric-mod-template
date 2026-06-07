package com.example.template.mixin;

import net.minecraft.client.MinecraftClient;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

/**
 * Example Mixin — injects into a vanilla Minecraft class.
 *
 * <p>Uncomment and customize the target class, injection point,
 * and callback logic for your mod.
 *
 * <p><b>Template:</b> This example targets {@code MinecraftClient} but you
 * should replace it with the class your mod needs to modify.
 */
@Mixin(MinecraftClient.class)
public class ExampleMixin {

    /**
     * Example injection: runs at the HEAD of {@code MinecraftClient.run()}.
     * Delete or replace this with your actual injection logic.
     */
    @Inject(method = "run", at = @At("HEAD"))
    private void onRun(CallbackInfo ci) {
        // Your injection logic here
    }
}
