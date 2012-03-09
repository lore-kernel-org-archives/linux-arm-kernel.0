From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 9 Mar 2012 09:38:12 -0700
Subject: [GIT PULL] ARM: OMAP: GPIO cleanup and device tree adaptation
In-Reply-To: <4F5A30DB.7060004@ti.com>
References: <4F5A30DB.7060004@ti.com>
Message-ID: <CACxGe6uo774Vf=rgnxxT6htFYSu7xROhgT-=Ernfbr9Lp-WvYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2012 at 9:33 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Grant,
>
> Please pull the patches for OMAP GPIO DT support.
> It is based on your current gpio/next branch.
>
> Thanks,
> Benoit

Merged, thanks.

g.

>
>
> The following changes since commit e4e449e82871c53ef3b22bd3a50fceabc0638926:
> ?Mark Brown (1):
> ? ? ? ?gpiolib: Add comments explaining the _cansleep() WARN_ON()s
>
> are available in the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_grant/for_3.4/dt_gpio
>
> Benoit Cousson (4):
> ? ? ?gpio/omap: Remove bank->id information and misc cleanup
> ? ? ?gpio/omap: Use devm_ API and add request_mem_region
> ? ? ?gpio/omap: Add DT support to GPIO driver
> ? ? ?gpio/omap: Fix IRQ handling for SPARSE_IRQ
>
> ?.../devicetree/bindings/gpio/gpio-omap.txt ? ? ? ? | ? 36 ++++
> ?arch/arm/plat-omap/include/plat/gpio.h ? ? ? ? ? ? | ? 22 +--
> ?drivers/gpio/gpio-omap.c ? ? ? ? ? ? ? ? ? ? ? ? ? | ?208 ++++++++++++++------
> ?3 files changed, 190 insertions(+), 76 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
