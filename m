From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 13:46:39 +0000
Subject: [PATCH 12/16] ARM: nomadik: move platform_data definitions
In-Reply-To: <CACRpkdb5Tkb5xGzuU=Mw9amfG+218dyzQaQsRZKm9cws71Vd9w@mail.gmail.com>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-12-git-send-email-arnd@arndb.de>
 <CACRpkdb5Tkb5xGzuU=Mw9amfG+218dyzQaQsRZKm9cws71Vd9w@mail.gmail.com>
Message-ID: <201209111346.40228.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Linus Walleij wrote:
> On Tue, Sep 11, 2012 at 5:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >  arch/arm/mach-nomadik/board-nhk8815.c                                |    2 +-
> >  arch/arm/mach-u300/core.c                                            |    2 +-
> >  arch/arm/mach-ux500/board-mop500.c                                   |    2 +-
> >  arch/arm/mach-ux500/cpu-db8500.c                                     |    2 +-
> >  arch/arm/mach-ux500/devices-common.h                                 |    2 +-
> >  arch/arm/mach-ux500/usb.c                                            |    2 +-
> >  drivers/crypto/ux500/cryp/cryp_core.c                                |    2 +-
> >  drivers/crypto/ux500/hash/hash_core.c                                |    2 +-
> >  drivers/input/keyboard/nomadik-ske-keypad.c                          |    2 +-
> >  drivers/mtd/nand/nomadik_nand.c                                      |    2 +-
> >  drivers/pinctrl/pinctrl-coh901.c                                     |    2 +-
> >  drivers/usb/musb/ux500_dma.c                                         |    2 +-
> >  .../include/mach => include/linux/platform_data}/crypto-ux500.h      |    0
> >  .../plat/ske.h => include/linux/platform_data/keypad-nomadik-ske.h   |    0
> >  .../mach/nand.h => include/linux/platform_data/mtd-nomadik-nand.h    |    0
> >  .../mach/gpio-u300.h => include/linux/platform_data/pinctrl-coh901.h |    0
> 
> I sent a patch for moving gpio-u300.h like this in commit
> 651728507140246e9cf4e809f1877cb2eddbc84e
> that is already in linux-next, is this the same patch or
> another one?

This my older patch that I did before the mini summit, but had not sent
out yet. It's probably best if I just drop this part of the patch.

	Arnd
