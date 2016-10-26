From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 26 Oct 2016 23:15:51 +0530
Subject: Pinctrl nodes missing for USB
In-Reply-To: <20161026165348.GA5600@kozik-lap>
References: <CANAwSgQ=pp93tDAERQ1iaryY3_pVhTeun=RaTo9ws1UKtS1PhA@mail.gmail.com>
 <20161026165348.GA5600@kozik-lap>
Message-ID: <CANAwSgSfRVDA_MXN9S+G0-u-mQNhPuPJ65FT_Y-ZH5nFpX4ptg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof

On 26 October 2016 at 22:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Oct 26, 2016 at 05:56:54PM +0530, Anand Moon wrote:
>> Hi All,
>>
>> I have tried to enable CONFIG_DEBUG_PINCTRL=y on Odroid XU4.
>> Just to try to understand the feature.
>> Is this feature suppoted for USB nodes.
>>
>> Below is the output of failed to pase pinctrl for USB nodes via dts.
>
> I do not see any question here...
>
> Anyway the devices not instantiated from DT will have such warning and
> USB devices are not present in DT, from obvious reasons... However what
> surprises me is why pinctrl_dt_to_map() was called for USB devices?
>
> Best regards,
> Krzysztof
>
[snip]

Sorry. I was just referring HK odroidxu3 dts for reference for dwc3 controller.

https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y/arch/arm/boot/dts/exynos5422-odroidxu3.dts#L525

I am just trying to understand if such a configuration possible for
dwc3 controllers.

Best Regards
Anand Moon
