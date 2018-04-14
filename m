From: jagan@amarulasolutions.com (Jagan Teki)
Date: Sat, 14 Apr 2018 15:55:08 +0530
Subject: [PATCH 3/7] bus: add bus driver for accessing Allwinner A64 DE2
In-Reply-To: <20180316175354.21437-4-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-4-icenowy@aosc.io>
Message-ID: <CAMty3ZBOSXu=+jQpsdnykioDGsp=VphSnzQdDDs_hh3Y1FPKyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 11:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The "Display Engine 2.0" (usually called DE2) on the Allwinner A64 SoC
> is different from the ones on other Allwinner SoCs. It requires a SRAM
> region to be claimed, otherwise all DE2 subblocks won't be accessible.
>
> Add a bus driver for the Allwinner A64 DE2 part which claims the SRAM
> region when probing.

Along with this bus driver, we also need
drivers/gpu/drm/sun4i/sun4i_drv.c which can usually drive the
pipelines like mixer0 and 1 are the cases for A64?

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
