From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 10:35:29 +0200
Subject: [PATCH v3 09/30] iio: adc: Threat A33 as thermal sensor and
 remove non thermal sun4i channel
In-Reply-To: <20180830154518.29507-10-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-10-embed3d@gmail.com>
Message-ID: <20180831083529.tdbgwlkchrr3j6py@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:44:57PM +0200, Philipp Rossak wrote:
> We want to use this driver mostly as thermal sensor, that still supports
> the adc for the older chips, thus we threat the A33 as thermal sensor.
> We also remove the adc channel without thermal support.

The A33 can definitely be used as an ADC, so we need to keep that support.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/d29f313a/attachment.sig>
