From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jan 2015 15:43:18 -0800
Subject: [PATCH v2] ARM: dts: am57xx-beagle-x15: Add dual ethernet
In-Reply-To: <1417726977-2496-1-git-send-email-balbi@ti.com>
References: <5480CADE.5010200@ti.com>
 <1417726977-2496-1-git-send-email-balbi@ti.com>
Message-ID: <20150107234318.GH13010@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141204 13:05]:
> Add CPSW DT binding to beagle X15 DTS in order to
> get ethernet working with this board.
> 
> Note that we're also adding sleep state which will
> place all pins in mux mode 15 - which means "driver
> off" - thus conserving power.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes since v1:
> 	- removed duplicated SoB from myself
> 	- Fixed s/Slave 1/Slave2/ in one comment
> 	- slightly improved commit log
> 

Applying into omap-for-v3.20/dt thanks.

Tony
