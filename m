From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 May 2015 19:37:49 +0900
Subject: [PATCH] ARM: dts: odroidxu3: Enable USB3 regulators
In-Reply-To: <1432803494-3516-1-git-send-email-linux.amoon@gmail.com>
References: <1432803494-3516-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <5568417D.9020605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 28.05.2015 o 17:58, Anand Moon pisze:
> Enable regulator for usbdrd3_0 and usbdrd3_1
> From the schematic pin diagram USB3_0 and USB3_1
> is regulated by LDO9 and LD011.
> 
> Fix the boot message of failed.
> [    3.503539] exynos-dwc3 usb at 12000000: Looking up vdd33-supply from device tree
> [    3.503556] exynos-dwc3 usb at 12000000: Looking up vdd33-supply property in node /usb at 12000000 failed
> [    3.503568] usb at 12000000 supply vdd33 not found, using dummy regulator
> [    3.509154] exynos-dwc3 usb at 12000000: Looking up vdd10-supply from device tree
> [    3.509170] exynos-dwc3 usb at 12000000: Looking up vdd10-supply property in node /usb at 12000000 failed
> [    3.509181] usb at 12000000 supply vdd10 not found, using dummy regulator
> [    3.917548] exynos-dwc3 usb at 12400000: Looking up vdd33-supply from device tree
> [    3.917565] exynos-dwc3 usb at 12400000: Looking up vdd33-supply property in node /usb at 12400000 failed
> [    3.917578] usb at 12400000 supply vdd33 not found, using dummy regulator
> [    3.922731] exynos-dwc3 usb at 12400000: Looking up vdd10-supply from device tree
> [    3.922747] exynos-dwc3 usb at 12400000: Looking up vdd10-supply property in node /usb at 12400000 failed
> 

Tested on Odroid XU3-Lite board:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
