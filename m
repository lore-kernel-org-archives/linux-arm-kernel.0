From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 2 Apr 2016 12:34:20 +0200
Subject: [PATCH 3/3] sunxi: A20-OLinuXino-LIME2: Add i2c2 bus in DTS
In-Reply-To: <1458932647-24268-3-git-send-email-haas@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <1458932647-24268-3-git-send-email-haas@computerlinguist.org>
Message-ID: <20160402103420.GH4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 25, 2016 at 08:04:07PM +0100, Michael Haas wrote:
> The A20 processor provides a third I2C bus on pins PB20 and PB21.
> The A20-OLinuXino-LIME2 exposes this bus via its GPIO1 port.
> 
> Olimex also provide a breakout board called the
> A20-OLinuXino-LIME2-UEXT. This change is required to properly
> support I2C on the UEXT connector found there.
> 
> Signed-off-by: Michael Haas <haas@computerlinguist.org>

What are the other options on that pin? Is it something exclusively
dedicated to i2c on the pin headers and the documentation, or is
anyone free to use that pin for whatever he wishes?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160402/d886af41/attachment.sig>
