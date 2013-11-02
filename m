From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Nov 2013 14:09:21 +0100
Subject: [PATCH v2 5/9] usb: gadget: s3c-hsotg: enable generic phy support
In-Reply-To: <1383335158-19730-6-git-send-email-matt.porter@linaro.org>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
 <1383335158-19730-6-git-send-email-matt.porter@linaro.org>
Message-ID: <1868561.m5DoOTCY2U@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt.

On Friday 01 of November 2013 15:45:54 Matt Porter wrote:
> Adds support for the generic PHY subsystem. Generic PHY
> support is probed and then the driver falls back to checking
> for an old style USB PHY and pdata if not found.
> 
> Signed-off-by: Matt Porter <matt.porter@linaro.org>
> ---
>  drivers/usb/gadget/s3c-hsotg.c | 54
> ++++++++++++++++++++++++++++-------------- 1 file changed, 36
> insertions(+), 18 deletions(-)

Patches that convert the driver to generic PHY have been already posted by 
Kamil Debski, as a part of a series[1] adding generic PHY drivers for S5P 
and Exynos SoCs. After that series, there will be no need to support the 
usb_phy subsystem in this driver anymore.

[1] http://www.mail-archive.com/linux-usb at vger.kernel.org/msg31189.html

Best regards,
Tomasz
