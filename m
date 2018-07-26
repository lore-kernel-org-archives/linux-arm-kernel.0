From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 26 Jul 2018 19:53:08 +0200
Subject: [linux-sunxi] [PATCH v3.1 01/10] clk: sunxi-ng: a64: Add minimal
 rate for video PLLs
In-Reply-To: <20180726171257.6688-2-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-2-icenowy@aosc.io>
Message-ID: <3702695.8LDZkQ7hxA@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?etrtek, 26. julij 2018 ob 19:12:48 CEST je Icenowy Zheng napisal(a):
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> According to documentation and experience with other similar SoCs, video
> PLLs don't work stable if their output frequency is set below 192 MHz.
> 
> Because of that, set minimal rate to both A64 video PLLs to 192 MHz.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
