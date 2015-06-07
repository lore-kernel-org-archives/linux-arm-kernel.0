From: linux.amoon@gmail.com (Anand Moon)
Date: Sun, 7 Jun 2015 08:10:24 +0530
Subject: [PATCHv3] ARM: dts: odroidxu3: Enable USB3 regulators
In-Reply-To: <5573AD39.2020105@samsung.com>
References: <1432909836-3952-1-git-send-email-linux.amoon@gmail.com>
 <5573AD39.2020105@samsung.com>
Message-ID: <CANAwSgS47vZJOhAdL85z9NVWvONZhwXZ+ZcCJ5tB7ie_UL7EUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2015 at 08:02, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> W dniu 29.05.2015 o 23:30, Anand Moon pisze:
>> Enable regulator for usbdrd3_0 and usbdrd3_1.
>> Looking at the schematic pin diagram for MAX77802
>> USB3_0 and USB3_1 is regulated by LDO9 and LD011.
>>
>> Fix the boot message of failed.
>> [    3.503539] exynos-dwc3 usb at 12000000: Looking up vdd33-supply from device tree
>> [    3.503556] exynos-dwc3 usb at 12000000: Looking up vdd33-supply property in node /usb at 12000000 failed
>> [    3.503568] usb at 12000000 supply vdd33 not found, using dummy regulator
>> [    3.509154] exynos-dwc3 usb at 12000000: Looking up vdd10-supply from device tree
>> [    3.509170] exynos-dwc3 usb at 12000000: Looking up vdd10-supply property in node /usb at 12000000 failed
>> [    3.509181] usb at 12000000 supply vdd10 not found, using dummy regulator
>> [    3.917548] exynos-dwc3 usb at 12400000: Looking up vdd33-supply from device tree
>> [    3.917565] exynos-dwc3 usb at 12400000: Looking up vdd33-supply property in node /usb at 12400000 failed
>> [    3.917578] usb at 12400000 supply vdd33 not found, using dummy regulator
>> [    3.922731] exynos-dwc3 usb at 12400000: Looking up vdd10-supply from device tree
>> [    3.922747] exynos-dwc3 usb at 12400000: Looking up vdd10-supply property in node /usb at 12400000 failed
>>
>> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> The patch no longer applies because of creation of common Odroid DTSI.
> Can you rebase it on Kukjin's for-next?
>
> Best regards,
> Krzysztof
>

Hi Krzysztof

Ok will do this.

-Anand Moon
>
