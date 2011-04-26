From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Tue, 26 Apr 2011 18:59:50 +0530
Subject: [PATCH v16 01/13] davinci vpbe: V4L2 display driver for DM644X SoC
In-Reply-To: <4DB6682F.2010109@gmail.com>
References: <1301737249-4012-1-git-send-email-manjunath.hadli@ti.com>,
	<4DB6682F.2010109@gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BBC5CAC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vladimir,
  Davinci family of devices consist of mainly Dm6446, Dm6467, Dm365, Dm355 which are dissimilar to OMAP devices in features and registers, and some (for ex Dm6467) in entire architecture. the current driver which you are seeing is DM6446, but the intent is to build-up the same code with support for DM355 and dM365 which belong to the same family and have almost same features and registers. There is no plan to share code with OMAP directory.

Thanks and Regards,
-Manju
________________________________________
From: Vladimir Pantelic [vladoman at gmail.com]
Sent: Tuesday, April 26, 2011 12:07 PM
To: Hadli, Manjunath
Cc: LMML; Kevin Hilman; LAK; Nori, Sekhar; dlos
Subject: Re: [PATCH v16 01/13] davinci vpbe: V4L2 display driver for DM644X SoC

Manjunath Hadli wrote:
> This is the display driver for Texas Instruments's DM644X family
> SoC. This patch contains the main implementation of the driver with the
> V4L2 interface. The driver implements the streaming model with
> support for both kernel allocated buffers and user pointers. It also
> implements all of the necessary IOCTLs necessary and supported by the
> video display device.

is there any hope/chance to make this share code with the omap v4l2
driver in drivers/media/video/omap?
