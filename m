From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Aug 2016 08:24:49 -0700
Subject: [PATCH] ARM: dts: am335x-wega: Add audio support
In-Reply-To: <7109f6e5-e7fd-4b60-98b7-85b9d78ef690@ti.com>
References: <1470841935-14190-1-git-send-email-s.mueller-klieser@phytec.de>
 <7109f6e5-e7fd-4b60-98b7-85b9d78ef690@ti.com>
Message-ID: <20160826152449.qmlrro3ka3vvh266@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160811 02:26]:
> On 08/10/16 18:12, Stefan M?ller-Klieser wrote:
> > The wega board has a TLV320AIC3007 connected via McASP0. In the default
> > configuration, no external crystal is mounted. We run a system clock of
> > 25 MHz, so we use the audio codec PLL for audio clock generation.
> 
> It is great that the "ti,da830-evm-audio" works for you. I hope I will have
> time soon to work on the McASP driver's CCF support in the near future.
> 
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applying into omap-for-v4.9/dt thanks.

Tony
