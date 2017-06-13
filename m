From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jun 2017 00:19:10 -0700
Subject: [PATCH 1/2] arm:omap2+: put omap_uart_phys/virt/lsr in .text
 section when ZIMAGE is true
In-Reply-To: <20170610102018.GX4902@n2100.armlinux.org.uk>
References: <1496888232-30764-1-git-send-email-hoeun.ryu@gmail.com>
 <6C915D66-C962-4264-89C1-C75A0530A2A1@gmail.com>
 <20170610102018.GX4902@n2100.armlinux.org.uk>
Message-ID: <20170613071910.GZ3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170610 03:24]:
> On Sat, Jun 10, 2017 at 01:44:00PM +0900, Hoeun Ryu wrote:
> > Hello, Russell.
> > 
> > Would you please review this patch ?
> 
> It's really up to Tony Lindgren, who is the OMAP maintainer.

I'll take a look today. I think we can simplify things quite
a bit as we no longer use machine type for configuring the
UART.

Regards,

Tony
