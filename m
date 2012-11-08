From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Nov 2012 13:52:05 +0900
Subject: [PATCH] ARM: EXYNOS5: Remove wrongly placed usb2.0 PHY_CFG
 definition from PMU_REG
In-Reply-To: <003b01cda5f8$f84e35c0$e8eaa140$%han@samsung.com>
References: <1349443590-29901-1-git-send-email-gautam.vivek@samsung.com>
 <003b01cda5f8$f84e35c0$e8eaa140$%han@samsung.com>
Message-ID: <0cec01cdbd6c$cd290e70$677b2b50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingoo Han wrote:
> 
> On Friday, October 05, 2012 10:27 PM Vivek Gautam wrote
> >
> > EXYNOS5_USB_CFG macro should actually point to USB20PHY_CFG
> > system register (base addr + 0x230). It's wrongly placed in regs-pmu.
> > Actual register at offset 0x230 in PMU is SEQ_TRANSITION4.
> >
> > Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> 
> As you mentioned, this definition is wrong.
> So, it should be removed.
> 
> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
> 
Applied, thanks.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
