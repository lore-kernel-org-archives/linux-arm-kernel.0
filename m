From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Oct 2012 10:22:22 +0100
Subject: [PATCH 4/6] ARM: ux500: Add UART support to the u9540 Device Tree
In-Reply-To: <20121011085002.GV12801@game.jcrosoft.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <1349882335-6786-5-git-send-email-lee.jones@linaro.org>
 <20121010190325.GT12801@game.jcrosoft.org>
 <20121011072927.GR9707@gmail.com>
 <20121011085002.GV12801@game.jcrosoft.org>
Message-ID: <20121011092222.GW9707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Oct 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:

> On 08:29 Thu 11 Oct     , Lee Jones wrote:
> > On Wed, 10 Oct 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > 
> > > On 16:18 Wed 10 Oct     , Lee Jones wrote:
> > > > Add the 3 UART nodes required to enable serial ports on the u9540.
> > > > 
> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  arch/arm/boot/dts/u9540.dts |   13 ++++++++++++-
> > > dts? it's dtsi
> > 
> > No it's not.
> so the name of the file is wrong s u9540 is a SoC name

The board could actually be called either ccu9540, or just 
u9540. I picked one and went with it. The full name is the
u9540 development board.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
