From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Jun 2014 11:06:20 +0100
Subject: [PATCH] regulator: convert to use gpio_desc internally
In-Reply-To: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
References: <E1X1IOQ-0007fV-1w@rmk-PC.arm.linux.org.uk>
Message-ID: <20140630100620.GV23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 05:55:54PM +0100, Russell King wrote:
> Convert the regulator GPIO handling to use a gpio descriptor rather than
> numbers.  This allows us to revise the interfaces to permit all GPIOs
> to be used with the regulator core.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/8bbd4166/attachment-0001.sig>
