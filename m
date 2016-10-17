From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Oct 2016 14:30:43 +0200
Subject: [PATCH] usb: ehci-platform: increase EHCI_MAX_RSTS to 4
In-Reply-To: <1476702719-10337-1-git-send-email-yamada.masahiro@socionext.com>
References: <1476702719-10337-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161017123043.GA15142@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 08:11:59PM +0900, Masahiro Yamada wrote:
> Socionext LD11 SoC (arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi)
> needs to handle 4 reset lines for EHCI.

Why?  What makes it different from other EHCI implementations?

thanks,

greg k-h
