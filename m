From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 16 Jun 2015 10:21:54 +0100
Subject: [PATCH v2 0/3] Add the efuse driver on rockchip platform
In-Reply-To: <557FE3EA.4000306@i2se.com>
References: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
 <557FE3EA.4000306@i2se.com>
Message-ID: <557FEAB2.1040101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,


On 16/06/15 09:52, Stefan Wahren wrote:
> Hi Caesar,
>
> [add Maxime and Srinivas]
>
> Am 16.06.2015 um 09:27 schrieb Caesar Wang:
>> The original driver is uploaded by Jianqun.
>> Here is his patchs:
>>      https://patchwork.kernel.org/patch/5410341/
>>      https://patchwork.kernel.org/patch/5410351/
>>
>> Jianqun, nevermind!
>> I check-pick it and re-upload the driver for the upstream.
>> e.g.:
>>      Tested by on minnie board.(kernel-4.1-rc8)
>>      cd /sys/devices/platform/ffb40000.efuse
>>      localhost ffb40000.efuse # cat cpu_leakage_show
>>      cpu_version_show
>>      The results:
>>              19
>>              2
>>
>> Changes in v2:
>> - Change the document decription.
>> - Move the efuse driver into driver/soc/vendor.
>> - update the efuse driver.
>> - Add the dts node on RK3288.
>>
>>
>
> i want to mention that there is a upcoming new framework suitable for
> efuse drivers:
>
> https://lkml.org/lkml/2015/5/21/643
>
> Unfortunately i don't know the current development state.
>

Currently this framework is used by atleast 3 drivers(qcom-tsens, 
qcom-cpr, begel-bone-cape manager) which are still floating in the 
mailing list.

I was hoping that these 3 users would getback with tested-by.. which did 
not happen for last 3-4 weeks.

I would appreciate, If you could try framework too, and let me know.

I added two of wrappers on top of v5 at: 
https://git.linaro.org/people/srinivas.kandagatla/linux.git/shortlog/refs/heads/nvmem-dev-v5


I think I should request Mark to take the framework.



--srini
> Regards
> Stefan
>
>
