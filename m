From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 26 Jan 2015 09:12:10 -0800
Subject: [PATCH v2] ARM: at91: sama5d4: dts: change the nand compatible
 string
In-Reply-To: <54C65838.4020707@atmel.com>
References: <1421656387-12538-2-git-send-email-josh.wu@atmel.com>
 <1421923305-10088-1-git-send-email-josh.wu@atmel.com>
 <54C0D872.6010005@atmel.com> <54C65838.4020707@atmel.com>
Message-ID: <20150126171210.GC5273@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 04:07:36PM +0100, Nicolas Ferre wrote:
> Le 22/01/2015 12:01, Nicolas Ferre a ?crit :
> > Le 22/01/2015 11:41, Josh Wu a ?crit :
> >> As we introduce a new "atmel,sama5d4-nand" compatible string for sama5d4,
> >> so we need to apply it for sama5d4 chip.
> >>
> >> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> > 
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Brian,
> > I suppose that it makes sense to keep this patch with the previous one.
> > So, can you take it in your tree?
> > 
> > Otherwise, it can take the at91 -> arm-soc route.

I actually would prefer that. The changes are sane enough by themselves,
and I don't often touch the arch/arm DTS files.

> I take it with me right now and try to send it to arm-soc for 3.20.

That's fine. Thanks.

Brian
