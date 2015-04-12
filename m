From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 13 Apr 2015 00:24:06 +0930
Subject: v3 Exynos5422 odroidxu3 pwm-fan control using thermal sensors
Message-ID: <1428850452-4178-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This work depeds upon work done by Lukasz Majewski <l.majewski@samsung.com>
and Sjoerd Simons <sjoerd.simons@collabora.co.uk> regarding the pwm-fan.

Changes from v1
        fixed the registration of thermal sensor to tmu_cpu0
Dropped patches.
        0005-pwm-samsung-Fix-output-race-on-disabling.patch
        0006-hwmon-pwm-fan-Update-the-duty-cycle-inorder-to-contr.patch
changes from v2
Added patch
	0006-hwmon-pwm-fan-Update-the-duty-cycle-inorder-to-contr.patch

-Anand Moon
