From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Feb 2018 09:46:31 -0800
Subject: [PATCH 0/9] ARM: dts: am33xx/am4372: Add suspend-resume support
In-Reply-To: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
References: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20180227174631.GD5448@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [180218 19:35]:
> Hi,
> This series is the last needed to enable suspend/resume on am335x/am437x
> along with [1]. It adds required dt nodes for the emif and core PM code
> to find the needed sram nodes and marks key devices with ti,no-idle so
> that the kernel does not idle them. With this suspend to mem can be achieved
> by following the steps described in [1].

Applying all these into omap-for-v4.17/dt thanks.

Tony
