From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jun 2010 19:09:44 +0100
Subject: [PATCH 2/2] ARM: PL011 baudrate extension for ST-Ericssons
	derivative
In-Reply-To: <1275385698-1599-1-git-send-email-linus.walleij@stericsson.com>
References: <1275385698-1599-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100601180944.GC6644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 01, 2010 at 11:48:18AM +0200, Linus Walleij wrote:
> @@ -90,6 +92,7 @@ static struct vendor_data vendor_arm = {
>  	.fifosize		= 16,
>  	.lcrh_tx                = UART011_LCRH,
>  	.lcrh_rx                = UART011_LCRH,
> +        .oversampling	        = false,

I assume these spaces rather than tabs are due to an editor error
rather than an email client problem?
