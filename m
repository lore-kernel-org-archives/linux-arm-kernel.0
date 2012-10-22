From: agraf@suse.de (Alexander Graf)
Date: Tue, 23 Oct 2012 00:11:02 +0200
Subject: 3.7-rc2 fails to build exynos target
Message-ID: <D9D88B79-F5F0-4C63-9E23-B1A919C7142A@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Howdy,

While updating to 3.7-rc2, I stumbled over a few compile issues with the exynos target. I won't get around to fix them, but wanted to give you a heads up and would like to see them resolved before 3.7 gets released :).

Config: http://csgraf.de/arm/exynos

Alex

[  674s] ERROR: "read_current_timer" [lib/rbtree_test.ko] undefined!
[  674s] ERROR: "read_current_timer" [lib/interval_tree_test.ko] undefined!
[  675s] ERROR: "read_current_timer" [drivers/video/udlfb.ko] undefined!
[  675s] ERROR: "cpufreq_cooling_register" [drivers/thermal/exynos_thermal.ko] undefined!
[  675s] ERROR: "cpufreq_cooling_unregister" [drivers/thermal/exynos_thermal.ko] undefined!
[  677s] ERROR: "s5p_csis_phy_enable" [drivers/media/platform/s5p-fimc/s5p-csis.ko] undefined!
[  678s] ERROR: "read_current_timer" [drivers/gpu/drm/udl/udl.ko] undefined!
[  678s] ERROR: "set_irq_flags" [drivers/gpio/gpio-adnp.ko] undefined!
[  678s] make[3]: *** [__modpost] Error 1
[  678s] make[2]: *** [modules] Error 2
[  678s] make[1]: *** [sub-make] Error 2
[  678s] make: *** [all] Error 2
[  678s] + test 2 -eq 0
[  678s] + test 00 -gt 0
[  678s] + exit 1
[  678s] error: Bad exit status from /var/tmp/rpm-tmp.qIAujD (%build)
