From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 6 Feb 2016 23:17:47 -0800
Subject: [PATCH v2 03/12] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160207071747.GA14010@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 07:41:20PM +0100, Gregory CLEMENT wrote:
> +static struct console mvebu_uart_console = {
> +	.name	= "ttyS",

You aren't ttyS, that's a reserved name for a different chip, please use
a new name and major/minor numbers.

thanks,

greg k-h
