From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 11 Oct 2012 20:06:12 +0200
Subject: [PATCH 4/6] ARM: ux500: Add UART support to the u9540 Device Tree
In-Reply-To: <20121011092222.GW9707@gmail.com>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <1349882335-6786-5-git-send-email-lee.jones@linaro.org>
 <20121010190325.GT12801@game.jcrosoft.org>
 <20121011072927.GR9707@gmail.com>
 <20121011085002.GV12801@game.jcrosoft.org>
 <20121011092222.GW9707@gmail.com>
Message-ID: <20121011180612.GY12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:22 Thu 11 Oct     , Lee Jones wrote:
> On Thu, 11 Oct 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On 08:29 Thu 11 Oct     , Lee Jones wrote:
> > > On Wed, 10 Oct 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > 
> > > > On 16:18 Wed 10 Oct     , Lee Jones wrote:
> > > > > Add the 3 UART nodes required to enable serial ports on the u9540.
> > > > > 
> > > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  arch/arm/boot/dts/u9540.dts |   13 ++++++++++++-
> > > > dts? it's dtsi
> > > 
> > > No it's not.
> > so the name of the file is wrong s u9540 is a SoC name
> 
> The board could actually be called either ccu9540, or just 
> u9540. I picked one and went with it. The full name is the
> u9540 development board.
so use ccu9540 as u9540 is the soc name so if we use u9540 as compatible we
expect to mach the soc and not a board

Best Regards,
J.
