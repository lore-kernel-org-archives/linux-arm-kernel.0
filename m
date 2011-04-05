From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Apr 2011 14:55:29 -0400 (EDT)
Subject: [PATCH] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <BANLkTimsz==SVdg0C6XEX6bCvmhEe79dew@mail.gmail.com>
References: <1301814792-9438-1-git-send-email-kostap@marvell.com>
	<BANLkTimsz==SVdg0C6XEX6bCvmhEe79dew@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1104051450550.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Apr 2011, saeed bishara wrote:

> On Sun, Apr 3, 2011 at 10:13 AM, Konstantin Porotchkin
> <kostap@marvell.com> wrote:
> > Disabled legacy support for ARMv6 archtecture on Dove platform.
> > Latest Dove HW uses only ARMv7 model.

What about older Dove hardware?  That's all I have for testing.

> > --- a/arch/arm/configs/dove_defconfig
> > +++ b/arch/arm/configs/dove_defconfig
[...]
> > -# CONFIG_MISC_DEVICES is not set
> > +CONFIG_LEGACY_PTY_COUNT=16
> > -CONFIG_LEGACY_PTY_COUNT=16
> > -# CONFIG_VGA_CONSOLE is not set
> > -CONFIG_USB_EHCI_TT_NEWSCHED=y
> > -CONFIG_INOTIFY=y
> > -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
> > -CONFIG_CRYPTO_CBC=y
> > -CONFIG_CRYPTO_MD5=y
> > -CONFIG_CRYPTO_DES=y

Those changes above are unrelated to the reason for this patch.  Please 
remove.


Nicolas
