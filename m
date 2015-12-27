From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 22:12:57 +0100
Subject: [PATCH v6 3/3] spi: sun4i: Add support for wait time between
 word transmissions
In-Reply-To: <1451145186-14235-4-git-send-email-mweseloh42@gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
 <1451145186-14235-4-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151227211257.GM30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 26, 2015 at 04:53:06PM +0100, Marcus Weseloh wrote:
> Modifies the sun4i SPI master driver to make use of the
> "spi-word-wait-ns" property. This specific SPI controller needs 3 clock
> cycles to set up the delay, which makes the minimum non-zero wait time
> on this hardware 4 clock cycles.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/03aa003c/attachment.sig>
