From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Jan 2015 18:13:44 -0800
Subject: [PATCH] ARM: dts: re-fromat AT91 part to match other entries
In-Reply-To: <54C660FE.3000401@atmel.com>
References: <20150112224203.GL22090@quad.lixom.net>
 <20150113230956.GA15087@quad.lixom.net>
 <20150113234759.GH3843@piout.net> <2263559.r5MiMeqJt6@wuerfel>
 <54C660FE.3000401@atmel.com>
Message-ID: <20150127021344.GA22154@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 04:45:02PM +0100, Nicolas Ferre wrote:
> Le 14/01/2015 10:05, Arnd Bergmann a ?crit :
> > On Wednesday 14 January 2015 00:47:59 Alexandre Belloni wrote:
> >>
> >> On 13/01/2015 at 15:09:56 -0800, Olof Johansson wrote :
> >>> On Tue, Jan 13, 2015 at 03:43:00PM +0100, Nicolas Ferre wrote:
> >>>> The entries are separated as ARM V4/V5 and ARM V7 as some other per-SoC config
> >>>> options may be removed in the near future.
> >>>>
> >>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>>> ---
> >>>> Hi Olof,
> >>>>
> >>>> This is an attempt to match other ARM SoC families format.
> >>>> If you feel that the patch can be good, do not hesitate to take it yourself. I
> >>>> don't plan to integrate it in any of my pull-request so it can appear quickly in
> >>>> arm-soc and can be used by everyone.
> >>>
> >>> Hi,
> >>>
> >>> If you see what Peter did, he split up the rules per-SoC based on how
> >>> things were selectable in Kconfig. Since you seem to have the Kconfig
> >>> entries already, how about doing the same? That way the same information
> >>> w.r.t. SoC family that you have as comments isn't lost either.
> >>>
> >>
> >> You didn't see the patch set yet because it depends on a lot of other
> >> series still being discussed but after the switch to multiplatform, the
> >> only config option left will be SOC_AT91RM9200, SOC_AT91SAM9 (both
> >> under SOC_SAM_V4_V5) and SOC_SAMA5, under SOC_SAM_V7.
> >>
> >> That's our plan, unless you feel that we should keep one config option
> >> per SoC.
> > 
> > With the patches that I prepared last year, all of AT91SAM9 becomes
> > one small file, so there really isn't any need to have separate Kconfig
> > options.
> 
> Hi Olof,
> 
> After what noted Alexandre and Arnd, don't you think my initial attempt
> was okay? Aka: ping ;-)

Ah, yes. Applied now.


-Olof
