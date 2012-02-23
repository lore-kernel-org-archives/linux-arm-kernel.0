From: stigge@antcom.de (Roland Stigge)
Date: Thu, 23 Feb 2012 22:11:23 +0100
Subject: [PATCH v2] ARM: LPC32xx: USB Support
In-Reply-To: <1330030842-3848-1-git-send-email-stigge@antcom.de>
References: <1330030842-3848-1-git-send-email-stigge@antcom.de>
Message-ID: <4F46AB7B.7010306@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/02/12 22:00, Roland Stigge wrote:
> This patch adds OHCI support to the LPC32xx ARM platform. Besides the trivial
> addition of platform "usb-ohci" support, fixes for the USB PLL have been added
> to arch/arm/mach-lpc32xx/clock.c, ported from NXP's lpclinux.com.

This applies on top of my LPC32xx base patch series recently integrated
into arm-soc. I can prepare a patch to apply cleanly to current
mainline, if necessary (please note that without the cited basic
patches, mach-lpc32xx would be seriously broken, anyway).

Thanks in advance,

Roland
