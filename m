From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 9 Dec 2010 10:04:47 -0700 (MST)
Subject: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap ->
	omap_i2c
In-Reply-To: <1291904657-32729-2-git-send-email-b-cousson@ti.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
	<1291904657-32729-2-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1012091003400.11479@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Dec 2010, Benoit Cousson wrote:

> The convention for omap device naming is omap_XXX.
> 
> Rename the device and driver name in order to stick
> to this naming convention.
> 
> Change device name in clock nodes as well.

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
