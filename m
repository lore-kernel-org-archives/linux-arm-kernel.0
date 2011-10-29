From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 29 Oct 2011 13:08:18 +0200
Subject: [git pull] trivial gpio build failure fixups
In-Reply-To: <CACxGe6sNC0FseUj2pSL0y4yEJaFg=gNAP=54Ow6n8jXe2mBapA@mail.gmail.com>
References: <CACxGe6sNC0FseUj2pSL0y4yEJaFg=gNAP=54Ow6n8jXe2mBapA@mail.gmail.com>
Message-ID: <CACxGe6t+P5DRb0nV6wAD78F=aSt=OtWxiRByOhNAEPhWDkHs6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, one more...

g.

The following changes since commit ec7ae517537ae5c7b0b2cd7f562dfa3e7a05b954:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6
(2011-10-28 16:44:18 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 devicetree/merge

Grant Likely (1):
      gpio: Fix ARM versatile-express build failure

Kalle Valo (1):
      of: include errno.h

Linus Walleij (1):
      ARM: mark empty gpio.h files empty

 arch/arm/mach-lpc32xx/include/mach/gpio.h  |    1 +
 arch/arm/mach-tegra/include/mach/gpio.h    |    1 +
 arch/arm/mach-u300/include/mach/gpio.h     |    1 +
 arch/arm/mach-vexpress/include/mach/gpio.h |    1 +
 include/linux/of.h                         |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-vexpress/include/mach/gpio.h


On Sat, Oct 29, 2011 at 12:57 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Hi Linus,
>
> nothing to say here, subject says it all.
>
> g.
>
> The following changes since commit ec7ae517537ae5c7b0b2cd7f562dfa3e7a05b954:
>
> ?Merge git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6
> (2011-10-28 16:44:18 -0700)
>
> are available in the git repository at:
>
> ?git://git.secretlab.ca/git/linux-2.6 devicetree/merge
>
> Grant Likely (1):
> ? ? ?gpio: Fix ARM versatile-express build failure
>
> Kalle Valo (1):
> ? ? ?of: include errno.h
>
> ?arch/arm/mach-vexpress/include/mach/gpio.h | ? ?1 +
> ?include/linux/of.h ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?2 files changed, 2 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-vexpress/include/mach/gpio.h
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
