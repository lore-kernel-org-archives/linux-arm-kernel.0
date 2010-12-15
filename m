From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 18:12:26 -0700 (MST)
Subject: [PATCH] OMAP: omap_device: use pdev as parameter to get rt_va
In-Reply-To: <alpine.DEB.2.00.1012141710260.15971@utopia.booyaka.com>
References: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com>
	<4D05D586.6090408@ti.com>
	<AANLkTik667cW19eCVNNLf3_dc9efFYms0H2z-fGU24Ob@mail.gmail.com>
	<alpine.DEB.2.00.1012141710260.15971@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1012141811380.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Omar

On Tue, 14 Dec 2010, Paul Walmsley wrote:

> - In your driver-to-core-OMAP integration code in arch/arm/*omap*, call 
> omap_hwmod_get_mpu_rt_va(), and pass that to the driver via an entry in 
> the struct platform_data.

One brief note here - this should have been more clear:

- In your driver-to-core-OMAP integration code in arch/arm/*omap*, call 
  omap_hwmod_get_mpu_rt_va(), and pass the virtual address that it returns 
  to the driver via an entry in the struct platform_data.


- Paul
