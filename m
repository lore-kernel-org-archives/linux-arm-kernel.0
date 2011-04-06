From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Apr 2011 09:05:08 -0400 (EDT)
Subject: [PATCH] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <BANLkTinJP1S_tUfTG8jeeZRTq80bCE8kvw@mail.gmail.com>
References: <1301814792-9438-1-git-send-email-kostap@marvell.com>
	<BANLkTimsz==SVdg0C6XEX6bCvmhEe79dew@mail.gmail.com>
	<alpine.LFD.2.00.1104051450550.28032@xanadu.home>
	<BANLkTinJP1S_tUfTG8jeeZRTq80bCE8kvw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1104060903471.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Apr 2011, saeed bishara wrote:

> On Tue, Apr 5, 2011 at 9:55 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > --- a/arch/arm/configs/dove_defconfig
> >> > +++ b/arch/arm/configs/dove_defconfig
> > [...]
> >> > -# CONFIG_MISC_DEVICES is not set
> >> > +CONFIG_LEGACY_PTY_COUNT=16
> >> > -CONFIG_LEGACY_PTY_COUNT=16
> >> > -# CONFIG_VGA_CONSOLE is not set
> >> > -CONFIG_USB_EHCI_TT_NEWSCHED=y
> >> > -CONFIG_INOTIFY=y
> >> > -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
> >> > -CONFIG_CRYPTO_CBC=y
> >> > -CONFIG_CRYPTO_MD5=y
> >> > -CONFIG_CRYPTO_DES=y
> >
> > Those changes above are unrelated to the reason for this patch. ?Please
> > remove.
> should we prepare a separate patch that syncs the dove_defconfig with
> latest kernel?

That would be preferable.  Only the removal of the CONFIG_ARMV6K items 
are relevant for this patch.


Nicolas
