From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 10 Apr 2015 01:14:14 +0930
Subject: v2 Exynos5422 odroidxu3 pwm-fan control using thermal sensors
Message-ID: <1428594259-3915-1-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This work depeds upon work done by Lukasz Majewski <l.majewski@samsung.com>
and Sjoerd Simons <sjoerd.simons@collabora.co.uk> regarding the pwm-fan.

Changes from v1
        fixed the registration of thermal sensor to tmu_cpu0
Dropped patches.
        0005-pwm-samsung-Fix-output-race-on-disabling.patch
        0006-hwmon-pwm-fan-Update-the-duty-cycle-inorder-to-contr.patch

-Anand Moon
