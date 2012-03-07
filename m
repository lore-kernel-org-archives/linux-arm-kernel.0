From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Mar 2012 03:18:16 -0800
Subject: [PATCH 0/4] S3C24XX: Another move of code to the new mach
 directory
In-Reply-To: <201203061057.15815.heiko@sntech.de>
References: <201203061057.15815.heiko@sntech.de>
Message-ID: <4F5743F8.4040001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/12 01:57, Heiko St?bner wrote:
> This series contains the easy moves of common code for the SMDKs,
> Simtec boards and device setup from plat-s3c24xx to mach-s3c24xx.
>
> It also contains an extra patch to keep the Simtec code more together.
>
> Changes to the Kconfig and Makefile will probably conflict with the
> S3C2416-SPI series posted sunday, but this is ok, as the SPI series
> will probably have to wait for 3.5 anyway and can be redone then.
>
OK, I agree so applied this whole series.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
