From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Feb 2012 17:27:19 +0000
Subject: [GIT PULL] [v3.3] fixes for arch-pxa in arm
In-Reply-To: <CAN1soZzwvefsZbJ4LXk-j0qjqQLTH-7Gp4ufgyncjbu-SevnZg@mail.gmail.com>
References: <CAN1soZwcL-ELxwW5MB7zNQOrr0YPpo6pXp40D7uEaKH6Li0haw@mail.gmail.com>
 <CAN1soZzwvefsZbJ4LXk-j0qjqQLTH-7Gp4ufgyncjbu-SevnZg@mail.gmail.com>
Message-ID: <201202211727.19754.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Haojian Zhuang wrote:
> On Sat, Feb 18, 2012 at 6:04 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
> > Hi Arnd,
> >
> > Here's the fixes for 3.3.
> >
> > The following changes since commit c38e23456278e967f094b08247ffc3711b1029b2:
> >
> >  i387: fix sense of sanity check (2012-02-15 08:05:18 -0800)
> >
> > are available in the git repository at:
> >  git://github.com/hzhuang1/linux.git fixes
> >
> > Axel Lin (2):
> >      ARM: pxa: fix error handling in pxa2xx_drv_pcmcia_probe
> >      pxa/hx4700: add platform device and I2C info for AK4641 codec
> >
> > Danny Kukawka (3):
> >      ARM: pxa: fix including linux/gpio.h twice
> >      arch/arm/mach-mmp/: some files include some headers twice
> >      arch/arm/mach-pxa/: included linux/gpio.h twice
> >
> > Haojian Zhuang (2):
> >      ARM: pxa: fix wrong parsing gpio event on spitz
> >      ARM: pxa: fix mixed declarations and code in sharpsl_pm

Hi Haojian,

I've had a look now, sorry for the late reply.

How urgent is "pxa/hx4700: add platform device and I2C info
for AK4641 codec" amongst these? If not so urgent, I would prefer
putting this one on next/fixes-non-critical or even next/board
for 3.4 while applying the reset on the fixes branch for 3.3.

I'd prefer to cut down on non-trivial fixes for 3.3 now that
we are at -rc4.

	Arnd
