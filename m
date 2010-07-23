From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Jul 2010 09:03:20 +0900
Subject: [PATCH v4] Samsung: add new card detection methods in s3c-sdhci
	driver (platform part)
In-Reply-To: <1279790980-29583-1-git-send-email-m.szyprowski@samsung.com>
References: <000501cb2977d6cf210846d630$%szyprowski@samsung.com>
	<1279790980-29583-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <004101cb29fa$7ad36bf0$707a43d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> On some Samsung SoCs not all SDHCI controllers have card detect (CD)
> line. For some embedded designs it is not even needed, because ususally
> the device (like SDIO flash memory or wifi controller) is permanently
> wired to the controller. There are also systems which have a card detect
> line connected to some of the external interrupt lines or the presence
> of the card depends on some other actions (like enabling a power
> regulator).
> 
> This patch adds all required changes to platform support code, so
> another patch, which extends the driver with support for the new card
> detection methods can be applied.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Ok..will apply soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
> 
> This a resend of the previous patch.
> 
> I hope these changes to platform specific code gets merged soon, so the
> changes to the driver can be merged as well.
> 
> The patch has been prepared against linux-next kernel tree from 20100722.
> 
> Changes since V3:
> - renamed patch to avoid confusion with the patch for the s3c-sdhci driver
>   itself - added "(platform part)" in subject
> 
> Changes since V2:
> - added support for HSMMC3 device
> 
> Changes since V1:
> - added support for gpio external interrupt card based detect method
>   directly to sdhci-s3c driver
> - removed s3c64xx compilation fix patch from the series
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
