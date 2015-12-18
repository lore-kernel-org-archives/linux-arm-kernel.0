From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Dec 2015 12:11:01 +0100
Subject: [PATCH v5 1/2] spi: dts: Add new device property to specifcy a
 wait time between word transmissions
In-Reply-To: <1450352427-25350-2-git-send-email-mweseloh42@gmail.com>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
 <1450352427-25350-2-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151218111101.GL30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 12:40:26PM +0100, Marcus Weseloh wrote:
> Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
> SPI slave devices to set a wait time between the transmission of words.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/b3e3cf54/attachment-0001.sig>
