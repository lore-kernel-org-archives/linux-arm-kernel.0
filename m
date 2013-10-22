From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Oct 2013 08:11:35 -0700
Subject: [PATCH V7 3/8] ARM: OMAP3+: use cpu0-cpufreq driver in device
 tree supported boot
In-Reply-To: <1381937948-27057-4-git-send-email-nm@ti.com>
References: <1381937948-27057-1-git-send-email-nm@ti.com>
 <1381937948-27057-4-git-send-email-nm@ti.com>
Message-ID: <20131022151135.GN15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [131016 08:39]:
> With OMAP3+ and AM33xx supported SoC having defined CPU device tree
> entries with operating-points and clock nodes defined, we can now use
> the SoC generic cpufreq-cpu0 driver by registering appropriate device.

Thanks I'm taking patches 1 - 3 from this series into
omap-for-v3.13/board-removal-take2 because of the dependencies.

Tony
