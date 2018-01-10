From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 10 Jan 2018 05:45:57 +0200
Subject: [PATCH 3/4] bcm2835-gpio-exp: Driver for GPIO expander via
 mailbox service
In-Reply-To: <CACRpkdb73jGGRm5OrXLGYSOjMni-NsOwdC7TXH2k+iAEnAvL2g@mail.gmail.com>
References: <cover.1514898134.git.baruch@tkos.co.il>
 <bcac00c71b29c359b59053a30d817a8f17d6731d.1514898134.git.baruch@tkos.co.il>
 <CACRpkdb73jGGRm5OrXLGYSOjMni-NsOwdC7TXH2k+iAEnAvL2g@mail.gmail.com>
Message-ID: <20180110034557.5sqpbsvt6ly6s2go@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Jan 03, 2018 at 11:08:15AM +0100, Linus Walleij wrote:
> On Tue, Jan 2, 2018 at 2:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> > +#include <linux/err.h>
> > +#include <linux/gpio.h>
> 
> Just use
> 
> #include <linux/driver.h>

You mean linux/gpio/driver.h, right?

I still need linux/gpio.h for GPIOF_DIR_*.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
