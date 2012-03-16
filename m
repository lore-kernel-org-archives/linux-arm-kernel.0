From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 16 Mar 2012 01:55:01 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120316012711.GD6065@S2101-09.ap.freescale.net>
References: <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
 <20120315142115.GB6065@S2101-09.ap.freescale.net>
 <4F621D09.2080806@freescale.com>
 <20120316012711.GD6065@S2101-09.ap.freescale.net>
Message-ID: <4F629D71.3050102@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Hmm, Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> is the binding document specifically for imx-sgtl5000 driver rather
> than for all fsl_ssi based machine drivers.  Since I have never seen
> and doubt will ever see the setup that two SSIs connect to two
> sgtl5000 codecs on any imx board, I do not see much point to update
> the documentation for that.
>
> If this is indeed a practical setup for PowerPC, it can be documented
> in the binding for PowerPC machine driver when there is future PowerPC
> machine drivers adopting the new binding.

Ok.  I was going to say that I'd like to see a template that applies to 
all SOCs with an SSI, but I guess that won't be that useful.

I'm just concerned that if there's no standard way to create bindings for 
machine drivers, we're going to end up with some kind of mess down the road.

-- 
Timur Tabi
Linux kernel developer at Freescale
