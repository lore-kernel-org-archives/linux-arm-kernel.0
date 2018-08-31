From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 10:34:36 +0200
Subject: [PATCH v3 08/30] iio: adc: remove hwmon structure
In-Reply-To: <20180830154518.29507-9-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-9-embed3d@gmail.com>
Message-ID: <20180831083436.prcidrdli7gdtb45@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:44:56PM +0200, Philipp Rossak wrote:
> We remove the hwmon structure that was requiered for the mfd driver.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

Same thing here, you should merge that in the commit that removes the
probe_mfd call.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/c60a3346/attachment.sig>
