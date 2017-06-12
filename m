From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Jun 2017 00:36:36 -0700
Subject: [PATCH 0/6] Init Clock frequences for accelerators
In-Reply-To: <20170607212730.33002-1-s-anna@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
Message-ID: <20170612073635.GT3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [170607 14:31]:
> Hi Tony,
> 
> The following series configures the initial frequencies for the required
> DPLLs and corresponding output divider clocks used by various remoteproc
> accelerators (DSP, IVAHD) on OMAP4, OMAP5 & DRA7xx/AM57xx SoCs and the
> GPU on DRA7xx/AM57xx SoCs. All these devices require Adaptive Voltage
> Scaling (AVS) to be programmed at all OPPs at boot time, which is
> programmed in the bootloader. Furthermore, DVFS is not supported on
> these domains implying a one-time OPP clock frequency setup.

Tero, care to comment or ack this series?

Regards,

Tony
