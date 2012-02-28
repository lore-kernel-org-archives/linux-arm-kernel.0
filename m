From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 28 Feb 2012 09:57:35 -0800
Subject: [PATCH v3] ARM: LPC32xx: USB Support
In-Reply-To: <1330178224-24999-2-git-send-email-stigge@antcom.de>
References: <1330178224-24999-1-git-send-email-stigge@antcom.de>
 <1330178224-24999-2-git-send-email-stigge@antcom.de>
Message-ID: <20120228175735.GB14290@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2012 at 02:57:04PM +0100, Roland Stigge wrote:
> This patch adds OHCI support to the LPC32xx ARM platform. Besides the trivial
> addition of platform "usb-ohci" support, fixes for the USB PLL have been added
> to arch/arm/mach-lpc32xx/clock.c, ported from NXP's lpclinux.com.
> 
> (This is the mach-lpc32xx specific part, the USB subsystem specific changes are
> in a separate patch for the USB maintainers.)

Do you want/need me to take both of these?  Or just the first one?  Or,
just ack the first one so the arm maintainers can take this one?  It's
your choice...

thanks,

greg k-h
