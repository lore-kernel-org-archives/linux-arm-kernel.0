From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 May 2014 09:50:55 -0700
Subject: [PATCH 0/2] Add VTT regulators for DDR3 AMx3xx Boards
In-Reply-To: <1399319909-53795-1-git-send-email-d-gerlach@ti.com>
References: <1399319909-53795-1-git-send-email-d-gerlach@ti.com>
Message-ID: <20140506165055.GM18474@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [140505 12:59]:
> The am335x-evmsk and am437x-gp-evm both have a gpio controlled regulator
> for DDR3 VTT voltage. This is configured by boot loader and previously
> just left at that but it is better to define a fixed regulator to control
> the gpio so that the kernel is aware of it.
> 
> Previous discussion here [1].
> 
> Original am437x-gp-evm patch has been updated to reflect actual voltage
> supplied by VTT regulator.

Thanks applying both into omap-for-v3.16/dt.

Tony
