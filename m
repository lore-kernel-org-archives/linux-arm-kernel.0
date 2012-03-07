From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Mar 2012 03:18:07 -0800
Subject: [PATCH 0/3] S3C24XX: Enable DMA on S3C2416 by sharing S3C2443-DMA
In-Reply-To: <201203041842.35420.heiko@sntech.de>
References: <201203041842.35420.heiko@sntech.de>
Message-ID: <4F5743EF.20603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/12 09:42, Heiko St?bner wrote:
> The S3C2416/2450 contains the same DMA register layout as the S3C2443.
> Therefore it can simply share this dma selection definition.
>
> As we use the S3C2443_DMA the S3C2416_DMA is no longer necessary. The
> third patch removes this remnant of the S3C24XX merge.
>
> The whole series was made on top of the recent S3C24XX merge.
>
Good, applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
