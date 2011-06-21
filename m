From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Jun 2011 11:45:28 +0200
Subject: [RFC][PATCH 0/5] USB: DWC OTG: Add dwc_otg driver for S5P6440
	samsung	SoC.
In-Reply-To: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
Message-ID: <001701cc2ff7$f468d3c0$dd3a7b40$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, June 21, 2011 9:04 AM p.paneri at samsung.com wrote:

> From: Praveen Paneri <p.paneri@samsung.com>
> 
> These patches modify DWC OTG driver for ARM and add it for ARM based SoCs.
> Currently it has been tested for Samsung's S5P6440. The development is
> still
> under process so these are not the best set of patches. They are just for
> review
> and not for merge. Intent of these patches is to show required
> modifications
> to make dwc_otg patches work on ARM.

What are the differences between DWC OTG hardware and OTG hardware found
in s3c64xx/s5pc100/s5pv210 and Exynos4 SoCs series? I've did a brief look
at register definitions and most of them looks same. Can this driver be
merged with s3c-hsotg.c driver?

> Following features are tested for basic functions on SMDK6440
> board after modifications:
> OTG HOST: HID and mass-storage
> OTG DEVICE: mass-storage and adb

Does it mean that HID or mass-storage (both host or gadget drivers) needs
modifications to get them working with this DWC OTG driver?

(snipped)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
