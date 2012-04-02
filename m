From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Apr 2012 14:00:04 -0700
Subject: [PATCH 0/6] S3C24XX: Add support for HSSPI on S3C2416/S3C2443
In-Reply-To: <201204022125.33629.heiko@sntech.de>
References: <201203121959.32966.heiko@sntech.de>
 <201204022125.33629.heiko@sntech.de>
Message-ID: <4F7A1354.5050904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> Am Montag 12 M?rz 2012, 19:59:32 schrieb Heiko St?bner:
>> The S3C2416/S3C2443/S3C2450 SoCs contain HSSPI controllers compatible
>> with the ones in the S3C64xx and later.
>>
>> The second patch modifying the dma selection depends on the series
>> enabling the dma support on the S3C2416, but as the whole s3c64xx-spi
>> driver needs dma support this should be ok.
>>
>> Tested on an Asus DR-900 ebook reader with a Marvell MR8686 using the
>> libertas driver.
>>
>>
>> This is a repost of the series adapted to changes resulting from the
>> other cleanup series.
>
> ping :-)
>
Thanks for your reminder ;)
Let me review it soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
