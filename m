From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Apr 2015 18:59:37 +0100
Subject: [PATCH v2 3/9] mfd: syscon: Add Atmel MC (Memory Controller)
 registers definition
In-Reply-To: <20150428125558.GD3687@piout.net>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1427138955-3617-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20150428123058.GC9169@x1> <20150428125558.GD3687@piout.net>
Message-ID: <20150428175937.GH9169@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Apr 2015, Alexandre Belloni wrote:

> Hi,
> 
> On 28/04/2015 at 13:30:58 +0100, Lee Jones wrote :
> > On Mon, 23 Mar 2015, Alexandre Belloni wrote:
> > 
> > > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > 
> > > The at91rm9200 SoC embeds a Memory Controller block which is used to
> > > configure several aspects of the platform:
> > > - AHB/APB Bus behavior
> > > - SDRAM Controller
> > > - EBI (External Bus Interface) and SMC (Static Memory Controller) config
> > > 
> > > Those registers might be accessed by different drivers, hence we need to
> > > define it as a syscon device.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  include/linux/mfd/syscon/atmel-mc.h | 144 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 144 insertions(+)
> > >  create mode 100644 include/linux/mfd/syscon/atmel-mc.h
> > 
> > I've lost context here.
> > 
> > Is it okay to take this now?
> > 
> 
> I'd say that it would be better to get that one through the AT91 tree
> along with the following patches as they depend on it. Is that okay with
> you?

Yes, no problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
