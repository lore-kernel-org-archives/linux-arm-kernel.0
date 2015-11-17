From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 17 Nov 2015 07:16:56 -0200
Subject: [PATCH v2 3/3] [media] include/media: move platform_data to
 linux/platform_data/media
In-Reply-To: <4084946.Zz4s9XrKbs@wuerfel>
References: <013152dcb3d4eaddd39aa4a37868430567bdc2d6.1447671420.git.mchehab@osg.samsung.com>
 <b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
 <4084946.Zz4s9XrKbs@wuerfel>
Message-ID: <20151117071656.498013a9@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, 16 Nov 2015 13:28:10 +0100
Arnd Bergmann <arnd@arndb.de> escreveu:

> I think we can also move some of the existing platform data headers to the same
> place, but that could be a separate patch:
> 
> $ git grep linux/platform_data drivers/media/
> drivers/media/platform/coda/coda-common.c:#include <linux/platform_data/coda.h>
> drivers/media/platform/soc_camera/mx2_camera.c:#include <linux/platform_data/camera-mx2.h>
> drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/camera-mx3.h>
> drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/dma-imx.h>
> drivers/media/platform/soc_camera/pxa_camera.c:#include <linux/platform_data/camera-pxa.h>
> drivers/media/platform/soc_camera/rcar_vin.c:#include <linux/platform_data/camera-rcar.h>

Fair enough. Just sent a separate patch to address that.

Regards,
Mauro
