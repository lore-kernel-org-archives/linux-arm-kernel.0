From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 16:54:30 +0100
Subject: [PATCH 11/11] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <1278339329-23739-11-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
	<1278339329-23739-11-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100731155430.GG27064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 05, 2010 at 04:15:29PM +0200, Uwe Kleine-K?nig wrote:
> +config ZRELADDR
> +	hex "Physical address of the decompressed kernel image"

Does it really make sense for users to be able to edit this?  I don't
think so as some platforms depend on its value being set appropriately,
plus the requirements for it aren't documented in the help text.
