From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 10:34:00 +0200
Subject: [PATCH v3 07/30] iio: adc: remove mfd_probe & sunwi_irq_init
 function
In-Reply-To: <20180830154518.29507-8-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-8-embed3d@gmail.com>
Message-ID: <20180831083400.fobo2c7w22fspyf4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:44:55PM +0200, Philipp Rossak wrote:
> In the previous commit we removed the function call, now we remove the
> unused functions.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

This will create a warning between the two commits, it should be
merged in the previous patch.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/6aaafcdb/attachment.sig>
