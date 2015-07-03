From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 3 Jul 2015 13:58:31 +0800
Subject: [RESEND PATCH 2/6] soc: Mediatek: Add SCPSYS CPU power domain
 driver
In-Reply-To: <20150623055351.GA22419@pengutronix.de>
References: <srv_scott.shu@mediatek.com>
 <1434650481-39421-1-git-send-email-scott.shu@mediatek.com>
 <1434650481-39421-3-git-send-email-scott.shu@mediatek.com>
 <20150623055351.GA22419@pengutronix.de>
Message-ID: <1435903111.5056.18.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,
   I just wonder can we separate the MTCMOS into cpu and non-cpu part? 
Just like qcom's xcc driver, they put cpu related code under
"arch/arm/mach-xxx" but put the others under "driver".

Thanks,
Scott  

On Tue, 2015-06-23 at 07:53 +0200, Sascha Hauer wrote:
> Hi Scott,
> 
> On Fri, Jun 19, 2015 at 02:01:17AM +0800, Scott Shu wrote:
> > This adds a CPU power domain driver for the Mediatek SCPSYS unit on
> > MT6580.
> 
> This seems to be support for the very same hardware as I am posting
> here:
> 
> https://lkml.org/lkml/2015/6/22/41
> 
> We should consolidate this.
> 
> My driver is currently handles all power domains except the CPUs while
> yours handles only the CPUs.
> I currently haven't looked whether CPUs can just be part of a power
> domain aswell, but if that works this would probably be the way to go.
> 
> Sascha
> 
> 
