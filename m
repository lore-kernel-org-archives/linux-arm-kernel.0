From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 17 Jan 2013 14:55:21 +0100 (CET)
Subject: [PATCH 2/8] pinctrl: add SDHI and MMCIF pin groups to sh7372
In-Reply-To: <CACRpkdbBcKttwoibRF9e2rXMN7CcxHkUgSmWCD5DjHEXyv9gGQ@mail.gmail.com>
References: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
 <1358356097-26180-3-git-send-email-g.liakhovetski@gmx.de>
 <CACRpkdbBcKttwoibRF9e2rXMN7CcxHkUgSmWCD5DjHEXyv9gGQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1301171454320.30897@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Jan 2013, Linus Walleij wrote:

> On Wed, Jan 16, 2013 at 6:08 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> 
> > Add pin groups for all three SDHI interfaces and two alternative pin
> > groups for the MMCIF interface on the sh7372 SoC.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I guess this needs to go on top of Laurent's patch set?

Sure, quoting patch 0/8:

<quote>
This series is based on recent work by Laurent and Simon. sh7372 and 
r8a7740 pinctrl support seems to be stable and, probably, won't change, 
so, also the base for these patches seems solid. Since the current pinctrl 
implementation for sh73a0 is likely to change, support for kzm9g isn't 
included in this series.
</quote>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
