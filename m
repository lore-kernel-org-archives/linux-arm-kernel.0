From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Aug 2011 18:57:26 +0200
Subject: PL08x driver in arch/arm/mach-pnx4008/dma.c
Message-ID: <CACRpkdYBYekj_uP=Pi_=sfDwn51naY4XoX8RK13f8d5ifs=j1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vitaly,

I noticed another copy of the ARM PL08x driver in the above path,
and we are now working to unify the different PL08x derivates in
drivers/dma/amba-pl08x.c

I couldn't find a maintainer in MAINTAINERS, but it seems you
wrote a lot of the code.

Are you or someone else maintaining the PNX4008 able to look
into moving over to the generic driver?

Thanks,
Linus Walleij
