From: robherring2@gmail.com (Rob Herring)
Date: Thu, 18 Apr 2013 22:06:46 -0500
Subject: linux-next ARM multi-platform randconfig errors
Message-ID: <5170B4C6.1030300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current errors in linux-next for ARM multi-platform randconfig builds.

Rob

arch/arm/mach-omap2/built-in.o:dss-common.c:(.init.text+0x6830): more undefined references to `usb_bind_phy' follow
board-paz00.c:(.text+0x1ecc): undefined reference to `cpu_do_idle'
board-paz00.c:(.text+0x1f4c): undefined reference to `cpu_do_idle'
drivers/built-in.o:(.data+0x327b8): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
drivers/built-in.o:(.data+0x9ae0): undefined reference to `uart_console_device'
board-paz00.c:(.text+0x1ecc): undefined reference to `cpu_do_idle'
board-paz00.c:(.text+0x1f4c): undefined reference to `cpu_do_idle'
drivers/built-in.o:(.data+0x327b8): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
drivers/built-in.o:(.data+0x9ae0): undefined reference to `uart_console_device'
drivers/built-in.o:drivers/md/dm-cache-target.c:429: more undefined references to `__udivdi3' follow
dss-common.c:(.cpuinit.text+0x38): undefined reference to `omap_get_wakeupgen_base'
dss-common.c:(.cpuinit.text+0x48): undefined reference to `omap_secure_apis_support'
dss-common.c:(.init.text+0x3db0): undefined reference to `omap_get_wakeupgen_base'
dss-common.c:(.init.text+0x3dcc): undefined reference to `omap_secure_apis_support'
dss-common.c:(.init.text+0x61b8): undefined reference to `usb_bind_phy'
dss-common.c:(.init.text+0x6314): undefined reference to `usb_bind_phy'
dss-common.c:(.init.text+0x6488): undefined reference to `usb_bind_phy'
dss-common.c:(.init.text+0x65ac): undefined reference to `usb_bind_phy'
dss-common.c:(.ref.text+0x10): undefined reference to `omap_get_wakeupgen_base'
dss-common.c:(.ref.text+0x18): undefined reference to `omap_secure_apis_support'
dss-common.c:(.ref.text+0x54): undefined reference to `omap4_hotplug_cpu'
dss-common.c:(.ref.text+0x58): undefined reference to `omap_secure_apis_support'
dss-common.c:(.text+0x11b5c): undefined reference to `usb_bind_phy'
ERROR: "of_get_next_parent" [drivers/media/v4l2-core/videodev.ko] undefined!
extcon-class.c:(.text+0x4ac4): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x4b34): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x5164): undefined reference to `abx500_get_register_interruptible'
extcon-class.c:(.text+0x52b4): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x5304): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x57a4): undefined reference to `abx500_get_register_interruptible'
platform-spi_imx.c:(.init.text+0x4a20): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.init.text+0x677c): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.init.text+0x70c4): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.init.text+0x825c): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.text+0x1ff0): undefined reference to `otg_ulpi_create'
tegra30-mc.c:(.exit.text+0x144): undefined reference to `uart_unregister_driver'
tegra30-mc.c:(.init.text+0x1e4c): undefined reference to `uart_register_driver'
tegra30-mc.c:(.init.text+0x1e6c): undefined reference to `uart_unregister_driver'
tegra30-mc.c:(.init.text+0x1ee0): undefined reference to `uart_parse_options'
tegra30-mc.c:(.init.text+0x1f04): undefined reference to `uart_set_options'
tegra30-mc.c:(.text+0x309d8): undefined reference to `uart_resume_port'
tegra30-mc.c:(.text+0x309fc): undefined reference to `uart_suspend_port'
tegra30-mc.c:(.text+0x30a94): undefined reference to `uart_handle_dcd_change'
tegra30-mc.c:(.text+0x30aa8): undefined reference to `uart_handle_cts_change'
tegra30-mc.c:(.text+0x30e5c): undefined reference to `uart_console_write'
tegra30-mc.c:(.text+0x31008): undefined reference to `uart_remove_one_port'
tegra30-mc.c:(.text+0x315b0): undefined reference to `do_SAK'
tegra30-mc.c:(.text+0x3161c): undefined reference to `uart_insert_char'
tegra30-mc.c:(.text+0x317d0): undefined reference to `uart_get_baud_rate'
tegra30-mc.c:(.text+0x318bc): undefined reference to `uart_update_timeout'
tegra30-mc.c:(.text+0x32c94): undefined reference to `uart_add_one_port'
tegra30-mc.c:(.text+0x32e94): undefined reference to `uart_write_wakeup'
tegra30-mc.c:(.text+0x33008): undefined reference to `uart_insert_char'
tegra30-mc.c:(.text+0x33030): undefined reference to `tty_flip_buffer_push'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/include/asm/kvm_vgic.h:59:11: error: 'CONFIG_KVM_ARM_MAX_VCPUS' undeclared here (not in a function)
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-imx/src.c:144: undefined reference to `reset_controller_register'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/gpio.c:133: undefined reference to `pwrdm_can_ever_lose_context'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-hotplug.c:33: undefined reference to `omap_get_wakeupgen_base'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-hotplug.c:38: undefined reference to `omap_secure_apis_support'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-hotplug.c:50: undefined reference to `omap4_hotplug_cpu'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-hotplug.c:52: undefined reference to `omap_secure_apis_support'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:2145: undefined reference to `clkdm_in_hwsup'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:2146: undefined reference to `clkdm_missing_idle_reporting'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:2147: undefined reference to `clkdm_hwmod_enable'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:2191: undefined reference to `clkdm_hwmod_disable'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:2235: undefined reference to `clkdm_hwmod_disable'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:2338: undefined reference to `clkdm_hwmod_disable'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:4071: undefined reference to `pwrdm_get_context_loss_count'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:691: undefined reference to `clkdm_add_sleepdep'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod.c:720: undefined reference to `clkdm_del_sleepdep'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-smp.c:204: undefined reference to `omap_get_wakeupgen_base'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-smp.c:224: undefined reference to `omap_secure_apis_support'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-smp.c:80: undefined reference to `omap_get_wakeupgen_base'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap-smp.c:94: undefined reference to `omap_secure_apis_support'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm.c:114: undefined reference to `clkdm_allow_idle'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm.c:117: undefined reference to `clkdm_sleep'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm.c:294: undefined reference to `omap_voltage_late_init'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm-debug.c:102: undefined reference to `pwrdm_read_pwrst'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm-debug.c:103: undefined reference to `pwrdm_read_pwrst'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm-debug.c:132: undefined reference to `pwrdm_state_switch'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm-debug.c:147: undefined reference to `pwrdm_for_each'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm-debug.c:148: undefined reference to `clkdm_for_each'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm-debug.c:155: undefined reference to `pwrdm_for_each'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/pm-debug.c:272: undefined reference to `pwrdm_for_each'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-spear/platsmp.c:111:58: error: 'SYS_LOCATION' undeclared (first use in this function)
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-spear/platsmp.c:25:33: error: 'VA_SCU_BASE' undeclared here (not in a function)
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-tegra/sleep-tegra20.S:200: undefined reference to `cpu_do_idle'
/var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-tegra/sleep-tegra30.S:69: Error: shift must be constant -- `orr r12,r12,r4,lsl r3'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/clk/ux500/clk-prcc.c:145:13: error: conflicting types for 'clk_reg_prcc_pclk'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/clk/ux500/clk-prcc.c:155:13: error: conflicting types for 'clk_reg_prcc_kclk'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/arm_big_little.c:101:3: error: too few arguments to function 'cpufreq_notify_transition'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/arm_big_little.c:234:2: error: unknown field 'have_multiple_policies' specified in initializer
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/arm_big_little.c:90:3: error: too few arguments to function 'cpufreq_notify_transition'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/spear-cpufreq.c:120: undefined reference to `cpufreq_frequency_table_target'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/spear-cpufreq.c:181: undefined reference to `cpufreq_frequency_table_cpuinfo'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/spear-cpufreq.c:187: undefined reference to `cpufreq_frequency_table_get_attr'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/spear-cpufreq.c:198: undefined reference to `cpufreq_frequency_table_put_attr'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/cpufreq/spear-cpufreq.c:35: undefined reference to `cpufreq_frequency_table_verify'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/md/dm-cache-target.c:429: undefined reference to `__udivdi3'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/md/dm-cache-target.c:429: undefined reference to `__umoddi3'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/mfd/ab8500-debugfs.c:95:23: fatal error: mach/irqs.h: No such file or directory
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/misc/spear13xx_pcie_gadget.c:23:23: fatal error: mach/pcie.h: No such file or directory
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:125: undefined reference to `abx500_get_register_interruptible'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:146: undefined reference to `abx500_mask_and_set_register_interruptible'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:209: undefined reference to `abx500_mask_and_set_register_interruptible'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:730:24: error: storage size of 'param' isn't known
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:730:7: error: implicit declaration of function 'pinconf_to_config_param' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:730:7: error: variable 'param' has initializer but incomplete type
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:731:24: error: storage size of 'argument' isn't known
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:731:7: error: implicit declaration of function 'pinconf_to_config_argument' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:731:7: error: variable 'argument' has initializer but incomplete type
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:733:2: error: 'PIN_CONFIG_OUTPUT' undeclared (first use in this function)
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/pinctrl/pinctrl-abx500.c:742:7: error: 'PIN_CONFIG_BIAS_PULL_DOWN' undeclared (first use in this function)
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/staging/android/logger.c:316:4: error: incompatible type for argument 3 of 'get_next_entry_by_uid'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/staging/android/logger.c:483:14: error: incompatible types when assigning to type 'uid_t' from type 'kuid_t'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/staging/android/logger.c:631:4: error: incompatible type for argument 3 of 'get_next_entry_by_uid'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/staging/android/logger.c:686:5: error: incompatible type for argument 3 of 'get_next_entry_by_uid'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/tty/serial/omap-serial.c:1196:14: error: 'struct uart_port' has no member named 'sysrq'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/usb/host/uhci-hcd.c:857:2: error: #error "missing bus glue for uhci-hcd"
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/usb/musb/tusb6010.c:1069: undefined reference to `usb_nop_xceiv_register'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/usb/musb/tusb6010.c:1137: undefined reference to `usb_nop_xceiv_unregister'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/usb/phy/phy-tegra-usb.c:638:32: error: 'ulpi_viewport_access_ops' undeclared (first use in this function)
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/video/omap2/dss/dpi.c:181:2: error: implicit declaration of function 'dsi_hsdiv_calc' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/video/omap2/dss/dpi.c:201:2: error: implicit declaration of function 'dsi_get_pll_clkin' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/video/omap2/dss/dpi.c:212:2: error: implicit declaration of function 'dsi_pll_calc' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:105:2: error: implicit declaration of function 'mfn_to_local_pfn' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:286:3: error: implicit declaration of function 'dma_alloc_coherent_mask' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:352:2: error: implicit declaration of function 'dma_capable' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:406:2: error: implicit declaration of function 'dma_mark_clean' [-Werror=implicit-function-declaration]
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:507:11: error: 'struct scatterlist' has no member named 'dma_length'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:513:5: error: 'struct scatterlist' has no member named 'dma_length'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:534:46: error: 'struct scatterlist' has no member named 'dma_length'
/var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/xen/swiotlb-xen.c:556:8: error: 'struct scatterlist' has no member named 'dma_length'
/var/lib/jenkins/jobs/linux-randconfig/workspace/include/linux/cpu_cooling.h:58:1: error: parameter name omitted
/var/lib/jenkins/jobs/linux-randconfig/workspace/include/linux/cpu_cooling.h:59:8: error: parameter name omitted
WARNING: vmlinux.o(.text+0x12b54): Section mismatch in reference from the function bcm_kona_smc_init() to the (unknown reference) .init.rodata:(unknown)

driversdrivers/md/dm-cache-target.c:429: more undefined references to `__udivdi3' follow
dss-common.c:(.cpuinit.text+0x38): undefined reference to `omap_get_wakeupgen_base'
dss-common.c:(.cpuinit.text+0x48): undefined reference to `omap_secure_apis_support'
dss-common.c:(.init.text+0x3db0): undefined reference to `omap_get_wakeupgen_base'
dss-common.c:(.init.text+0x3dcc): undefined reference to `omap_secure_apis_support'
dss-common.c:(.init.text+0x61b8): undefined reference to `usb_bind_phy'
dss-common.c:(.init.text+0x6314): undefined reference to `usb_bind_phy'
dss-common.c:(.init.text+0x6488): undefined reference to `usb_bind_phy'
dss-common.c:(.init.text+0x65ac): undefined reference to `usb_bind_phy'
dss-common.c:(.ref.text+0x10): undefined reference to `omap_get_wakeupgen_base'
dss-common.c:(.ref.text+0x18): undefined reference to `omap_secure_apis_support'
dss-common.c:(.ref.text+0x54): undefined reference to `omap4_hotplug_cpu'
dss-common.c:(.ref.text+0x58): undefined reference to `omap_secure_apis_support'
dss-common.c:(.text+0x11b5c): undefined reference to `usb_bind_phy'
ERROR: "of_get_next_parent" [drivers/media/v4l2-core/videodev.ko] undefined!
extcon-class.c:(.text+0x4ac4): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x4b34): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x5164): undefined reference to `abx500_get_register_interruptible'
extcon-class.c:(.text+0x52b4): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x5304): undefined reference to `abx500_mask_and_set_register_interruptible'
extcon-class.c:(.text+0x57a4): undefined reference to `abx500_get_register_interruptible'
platform-spi_imx.c:(.init.text+0x4a20): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.init.text+0x677c): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.init.text+0x70c4): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.init.text+0x825c): undefined reference to `reset_controller_register'
platform-spi_imx.c:(.text+0x1ff0): undefined reference to `otg_ulpi_create'
tegra30-mc.c:(.exit.text+0x144): undefined reference to `uart_unregister_driver'
tegra30-mc.c:(.init.text+0x1e4c): undefined reference to `uart_register_driver'
tegra30-mc.c:(.init.text+0x1e6c): undefined reference to `uart_unregister_driver'
tegra30-mc.c:(.init.text+0x1ee0): undefined reference to `uart_parse_options'
tegra30-mc.c:(.init.text+0x1f04): undefined reference to `uart_set_options'
tegra30-mc.c:(.text+0x309d8): undefined reference to `uart_resume_port'
tegra30-mc.c:(.text+0x309fc): undefined reference to `uart_suspend_port'
tegra30-mc.c:(.text+0x30a94): undefined reference to `uart_handle_dcd_change'
tegra30-mc.c:(.text+0x30aa8): undefined reference to `uart_handle_cts_change'
tegra30-mc.c:(.text+0x30e5c): undefined reference to `uart_console_write'
tegra30-mc.c:(.text+0x31008): undefined reference to `uart_remove_one_port'
tegra30-mc.c:(.text+0x315b0): undefined reference to `do_SAK'
tegra30-mc.c:(.text+0x3161c): undefined reference to `uart_insert_char'
tegra30-mc.c:(.text+0x317d0): undefined reference to `uart_get_baud_rate'
tegra30-mc.c:(.text+0x318bc): undefined reference to `uart_update_timeout'
tegra30-mc.c:(.text+0x32c94): undefined reference to `uart_add_one_port'
tegra30-mc.c:(.text+0x32e94): undefined reference to `uart_write_wakeup'
tegra30-mc.c:(.text+0x33008): undefined reference to `uart_insert_char'
tegra30-mc.c:(.text+0x33030): undefined reference to `tty_flip_buffer_push'
arch/arm/include/asm/kvm_vgic.h:59:11: error: 'CONFIG_KVM_ARM_MAX_VCPUS' undeclared here (not in a function)
arch/arm/mach-imx/src.c:144: undefined reference to `reset_controller_register'
arch/arm/mach-omap2/gpio.c:133: undefined reference to `pwrdm_can_ever_lose_context'
arch/arm/mach-omap2/omap-hotplug.c:33: undefined reference to `omap_get_wakeupgen_base'
arch/arm/mach-omap2/omap-hotplug.c:38: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/omap-hotplug.c:50: undefined reference to `omap4_hotplug_cpu'
arch/arm/mach-omap2/omap-hotplug.c:52: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/omap_hwmod.c:2145: undefined reference to `clkdm_in_hwsup'
arch/arm/mach-omap2/omap_hwmod.c:2146: undefined reference to `clkdm_missing_idle_reporting'
arch/arm/mach-omap2/omap_hwmod.c:2147: undefined reference to `clkdm_hwmod_enable'
arch/arm/mach-omap2/omap_hwmod.c:2191: undefined reference to `clkdm_hwmod_disable'
arch/arm/mach-omap2/omap_hwmod.c:2235: undefined reference to `clkdm_hwmod_disable'
arch/arm/mach-omap2/omap_hwmod.c:2338: undefined reference to `clkdm_hwmod_disable'
arch/arm/mach-omap2/omap_hwmod.c:4071: undefined reference to `pwrdm_get_context_loss_count'
arch/arm/mach-omap2/omap_hwmod.c:691: undefined reference to `clkdm_add_sleepdep'
arch/arm/mach-omap2/omap_hwmod.c:720: undefined reference to `clkdm_del_sleepdep'
arch/arm/mach-omap2/omap-smp.c:204: undefined reference to `omap_get_wakeupgen_base'
arch/arm/mach-omap2/omap-smp.c:224: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/omap-smp.c:80: undefined reference to `omap_get_wakeupgen_base'
arch/arm/mach-omap2/omap-smp.c:94: undefined reference to `omap_secure_apis_support'
arch/arm/mach-omap2/pm.c:114: undefined reference to `clkdm_allow_idle'
arch/arm/mach-omap2/pm.c:117: undefined reference to `clkdm_sleep'
arch/arm/mach-omap2/pm.c:294: undefined reference to `omap_voltage_late_init'
arch/arm/mach-omap2/pm-debug.c:102: undefined reference to `pwrdm_read_pwrst'
arch/arm/mach-omap2/pm-debug.c:103: undefined reference to `pwrdm_read_pwrst'
arch/arm/mach-omap2/pm-debug.c:132: undefined reference to `pwrdm_state_switch'
arch/arm/mach-omap2/pm-debug.c:147: undefined reference to `pwrdm_for_each'
arch/arm/mach-omap2/pm-debug.c:148: undefined reference to `clkdm_for_each'
arch/arm/mach-omap2/pm-debug.c:155: undefined reference to `pwrdm_for_each'
arch/arm/mach-omap2/pm-debug.c:272: undefined reference to `pwrdm_for_each'
arch/arm/mach-spear/platsmp.c:111:58: error: 'SYS_LOCATION' undeclared (first use in this function)
arch/arm/mach-spear/platsmp.c:25:33: error: 'VA_SCU_BASE' undeclared here (not in a function)
arch/arm/mach-tegra/sleep-tegra20.S:200: undefined reference to `cpu_do_idle'
arch/arm/mach-tegra/sleep-tegra30.S:69: Error: shift must be constant -- `orr r12,r12,r4,lsl r3'
drivers/clk/ux500/clk-prcc.c:145:13: error: conflicting types for 'clk_reg_prcc_pclk'
drivers/clk/ux500/clk-prcc.c:155:13: error: conflicting types for 'clk_reg_prcc_kclk'
drivers/cpufreq/arm_big_little.c:101:3: error: too few arguments to function 'cpufreq_notify_transition'
drivers/cpufreq/arm_big_little.c:234:2: error: unknown field 'have_multiple_policies' specified in initializer
drivers/cpufreq/arm_big_little.c:90:3: error: too few arguments to function 'cpufreq_notify_transition'
drivers/cpufreq/spear-cpufreq.c:120: undefined reference to `cpufreq_frequency_table_target'
drivers/cpufreq/spear-cpufreq.c:181: undefined reference to `cpufreq_frequency_table_cpuinfo'
drivers/cpufreq/spear-cpufreq.c:187: undefined reference to `cpufreq_frequency_table_get_attr'
drivers/cpufreq/spear-cpufreq.c:198: undefined reference to `cpufreq_frequency_table_put_attr'
drivers/cpufreq/spear-cpufreq.c:35: undefined reference to `cpufreq_frequency_table_verify'
drivers/md/dm-cache-target.c:429: undefined reference to `__udivdi3'
drivers/md/dm-cache-target.c:429: undefined reference to `__umoddi3'
drivers/mfd/ab8500-debugfs.c:95:23: fatal error: mach/irqs.h: No such file or directory
drivers/misc/spear13xx_pcie_gadget.c:23:23: fatal error: mach/pcie.h: No such file or directory
drivers/pinctrl/pinctrl-abx500.c:125: undefined reference to `abx500_get_register_interruptible'
drivers/pinctrl/pinctrl-abx500.c:146: undefined reference to `abx500_mask_and_set_register_interruptible'
drivers/pinctrl/pinctrl-abx500.c:209: undefined reference to `abx500_mask_and_set_register_interruptible'
drivers/pinctrl/pinctrl-abx500.c:730:24: error: storage size of 'param' isn't known
drivers/pinctrl/pinctrl-abx500.c:730:7: error: implicit declaration of function 'pinconf_to_config_param' [-Werror=implicit-function-declaration]
drivers/pinctrl/pinctrl-abx500.c:730:7: error: variable 'param' has initializer but incomplete type
drivers/pinctrl/pinctrl-abx500.c:731:24: error: storage size of 'argument' isn't known
drivers/pinctrl/pinctrl-abx500.c:731:7: error: implicit declaration of function 'pinconf_to_config_argument' [-Werror=implicit-function-declaration]
drivers/pinctrl/pinctrl-abx500.c:731:7: error: variable 'argument' has initializer but incomplete type
drivers/pinctrl/pinctrl-abx500.c:733:2: error: 'PIN_CONFIG_OUTPUT' undeclared (first use in this function)
drivers/pinctrl/pinctrl-abx500.c:742:7: error: 'PIN_CONFIG_BIAS_PULL_DOWN' undeclared (first use in this function)
drivers/staging/android/logger.c:316:4: error: incompatible type for argument 3 of 'get_next_entry_by_uid'
drivers/staging/android/logger.c:483:14: error: incompatible types when assigning to type 'uid_t' from type 'kuid_t'
drivers/staging/android/logger.c:631:4: error: incompatible type for argument 3 of 'get_next_entry_by_uid'
drivers/staging/android/logger.c:686:5: error: incompatible type for argument 3 of 'get_next_entry_by_uid'
drivers/tty/serial/omap-serial.c:1196:14: error: 'struct uart_port' has no member named 'sysrq'
drivers/usb/host/uhci-hcd.c:857:2: error: #error "missing bus glue for uhci-hcd"
drivers/usb/musb/tusb6010.c:1069: undefined reference to `usb_nop_xceiv_register'
drivers/usb/musb/tusb6010.c:1137: undefined reference to `usb_nop_xceiv_unregister'
drivers/usb/phy/phy-tegra-usb.c:638:32: error: 'ulpi_viewport_access_ops' undeclared (first use in this function)
drivers/video/omap2/dss/dpi.c:181:2: error: implicit declaration of function 'dsi_hsdiv_calc' [-Werror=implicit-function-declaration]
drivers/video/omap2/dss/dpi.c:201:2: error: implicit declaration of function 'dsi_get_pll_clkin' [-Werror=implicit-function-declaration]
drivers/video/omap2/dss/dpi.c:212:2: error: implicit declaration of function 'dsi_pll_calc' [-Werror=implicit-function-declaration]
drivers/xen/swiotlb-xen.c:105:2: error: implicit declaration of function 'mfn_to_local_pfn' [-Werror=implicit-function-declaration]
drivers/xen/swiotlb-xen.c:286:3: error: implicit declaration of function 'dma_alloc_coherent_mask' [-Werror=implicit-function-declaration]
drivers/xen/swiotlb-xen.c:352:2: error: implicit declaration of function 'dma_capable' [-Werror=implicit-function-declaration]
drivers/xen/swiotlb-xen.c:406:2: error: implicit declaration of function 'dma_mark_clean' [-Werror=implicit-function-declaration]
drivers/xen/swiotlb-xen.c:507:11: error: 'struct scatterlist' has no member named 'dma_length'
drivers/xen/swiotlb-xen.c:513:5: error: 'struct scatterlist' has no member named 'dma_length'
drivers/xen/swiotlb-xen.c:534:46: error: 'struct scatterlist' has no member named 'dma_length'
drivers/xen/swiotlb-xen.c:556:8: error: 'struct scatterlist' has no member named 'dma_length'
include/linux/cpu_cooling.h:58:1: error: parameter name omitted
include/linux/cpu_cooling.h:59:8: error: parameter name omitted
WARNING: arch/arm/mach-bcm/built-in.o(.text+0x104): Section mismatch in reference from the function bcm_kona_smc_init() to the (unknown reference) .init.rodata:(unknown)
