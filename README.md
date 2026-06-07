# Fabric Mod Template

适用于 **Minecraft 1.21.4** 的 Fabric 客户端模组模板。从 [Auto Sprint](https://github.com/lilyco-42/auto-sprint) 模组提取而来。

## 特性

- ✅ **Fabric Loom** 构建系统 (Gradle 8.x)
- ✅ **Mixin** 注入支持 — 修改原版代码
- ✅ **Fabric API** 集成 — 事件系统、按键绑定、渲染 API
- ✅ **中英文双语** 语言文件 (`zh_cn.json` + `en_us.json`)
- ✅ **开箱即用** 的按键绑定 + Action Bar 反馈
- ✅ **详细注释** — 每个类和方法都有 Javadoc
- ✅ **完整 `.gitignore`** — 排除构建产物和 IDE 文件

## 快速开始

### 方式 A：使用初始化脚本（推荐，Linux/macOS）

```bash
# 1. 克隆模板
git clone https://github.com/lilyco-42/fabric-mod-template.git my-mod
cd my-mod

# 2. 运行初始化脚本
chmod +x init-mod.sh
./init-mod.sh my-mod "My Mod" com.example.mymod com.example MyMod

# 3. 构建
./gradlew build
```

### 方式 B：手动初始化（Windows / 任何系统）

根据下表在以下文件中查找并替换占位符：

| 占位符 | 说明 | 示例 |
|--------|------|------|
| `template-mod` | Mod ID（只用小写字母和连字符） | `auto-sprint` |
| `Template Mod` | 显示名称 | `Auto Sprint` |
| `com.example.template` | Java 包名 | `com.example.autosprint` |
| `com.example` | Maven Group | `com.example` |
| `TemplateMod` | 主类名（PascalCase） | `AutoSprintMod` |

**需要修改的文件：**

| 文件 | 修改内容 |
|------|----------|
| `gradle.properties` | `archives_base_name`, `maven_group` |
| `src/main/resources/fabric.mod.json` | `id`, `name`, `entrypoints` |
| `src/main/resources/template-mod.mixins.json` | `package` |
| `src/main/java/com/example/template/TemplateMod.java` | 包名、类名、`MOD_ID` |

**需要重命名的目录/文件：**

| 原路径 | 新路径 |
|--------|--------|
| `src/main/java/com/example/template/` | `src/main/java/your/package/` |
| `src/main/java/com/example/template/TemplateMod.java` | `src/main/java/your/package/YourMod.java` |
| `src/main/resources/template-mod.mixins.json` | `src/main/resources/your-mod.mixins.json` |
| `src/main/resources/assets/template-mod/` | `src/main/resources/assets/your-mod/` |

## 项目结构

```
├── build.gradle                 # Gradle 构建脚本
├── gradle.properties             # 版本号等变量
├── settings.gradle               # 插件仓库配置
├── gradlew / gradlew.bat         # Gradle Wrapper
├── gradle/wrapper/
├── init-mod.sh                   # 初始化脚本 (Linux/macOS)
├── LICENSE                       # MIT
├── README.md                     # ← 你正在看的文件
└── src/main/
    ├── java/com/example/template/
    │   ├── TemplateMod.java      # Mod 入口（ClientModInitializer）
    │   └── mixin/
    │       └── ExampleMixin.java # Mixin 示例模板
    └── resources/
        ├── fabric.mod.json       # Mod 元数据
        ├── template-mod.mixins.json  # Mixin 配置
        └── assets/template-mod/lang/
            ├── en_us.json        # 英文翻译
            └── zh_cn.json        # 中文翻译
```

## 构建 & 测试

```bash
# 编译
./gradlew build

# 产物位置
ls build/libs/template-mod-1.0.0.jar

# 开发测试（自动启动 Minecraft 客户端）
./gradlew runClient

# 生成 Minecraft 反混淆源码（用于 IDE 代码补全）
./gradlew genSources
```

## 版本信息

| 组件 | 版本 |
|------|------|
| Minecraft | 1.21.4 |
| Fabric Loader | 0.19.3 |
| Fabric API | 0.119.4 |
| Yarn Mappings | 1.21.4+build.8 |
| Gradle | 8.12 |
| Java | 21 |

> ⚠️ 版本号会随时间更新。请访问 [Fabric 开发者页面](https://fabricmc.net/develop) 获取最新版本号，并更新 `gradle.properties`。

## 添加 Mixin

1. 在 `src/main/java/<package>/mixin/` 下创建 Mixin 类
2. 在 `<modid>.mixins.json` 的 `"client"` (或 `"server"`) 数组中注册
3. 参考 `ExampleMixin.java` 中的注解模板

## 从模板创建的项目

- [Auto Sprint](https://github.com/lilyco-42/auto-sprint) — 自动疾跑
- [Buried Treasure Finder](https://github.com/lilyco-42/buried-treasure-finder) — 宝藏自动计算

## 参考资源

- [Fabric Wiki](https://fabricmc.net/wiki/start)
- [Fabric Example Mod](https://github.com/FabricMC/fabric-example-mod)
- [Mixin 官方文档](https://github.com/SpongePowered/Mixin/wiki)
- [Yarn 映射查询](https://linkie.shedaniel.dev/mappings)
- [Modrinth](https://modrinth.com/) / [CurseForge](https://www.curseforge.com/minecraft) — 分发平台

## 许可

MIT
