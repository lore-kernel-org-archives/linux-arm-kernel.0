From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 23 Apr 2014 16:18:55 +0200
Subject: [PATCH v2 03/38] pinctrl: mvebu: new driver for Orion platforms
In-Reply-To: <CACRpkdaDLJitKqrYrbnEdiSqM1XQoAwT2AffRX0z+o70gmPTYA@mail.gmail.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdaDLJitKqrYrbnEdiSqM1XQoAwT2AffRX0z+o70gmPTYA@mail.gmail.com>
Message-ID: <20140423161855.09e95323@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Linus Walleij,

On Wed, 23 Apr 2014 16:17:03 +0200, Linus Walleij wrote:
> On Tue, Apr 22, 2014 at 11:26 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> 
> > This commit extends the pinctrl mvebu logic with a new driver to cover
> > Orion5x SoC. It supports the definitions for the 5181l, 5182 and 5281
> > variants of Orion5x, which are the three ones supported by the old
> > style MPP code in arch/arm/mach-orion5x/.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> Nothing very controversial about this,

Yeah, just a boring list of pins and functions :-)

> shall I just apply it or do you need it to be kept together with other stuff?

I'll let the mvebu maintainers answer this. Since there is no build
dependency with the rest of the series, I guess it could go through
your tree, but I leave the decision to the mvebu maintainers.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
