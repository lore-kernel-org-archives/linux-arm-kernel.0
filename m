From: wxt@rock-chips.com (Caesar Wang)
Date: Sat, 02 Jul 2016 08:57:21 +0800
Subject: [PATCH v2] arm64: dts: rockchip: add the power domain node for
 rk3399
In-Reply-To: <CABxcv=nJ4jaeBwPOfcKTmBpSHSD1wX-kJ2oi-bFki4=Dae0tEw@mail.gmail.com>
References: <1467347575-11806-1-git-send-email-wxt@rock-chips.com>
 <CABxcv=nJ4jaeBwPOfcKTmBpSHSD1wX-kJ2oi-bFki4=Dae0tEw@mail.gmail.com>
Message-ID: <57771171.2030701@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2016?07?02? 01:09, Javier Martinez Canillas wrote:
> Hello Caesar,
>
> On Fri, Jul 1, 2016 at 12:32 AM, Caesar Wang <wxt@rock-chips.com> wrote:
>> From: Elaine Zhang <zhangqing@rock-chips.com>
>>
>> In order to meet low power requirements, a power management unit (PMU) is
>> designed for controlling power resources in RK3399. The RK3399 PMU is
>> dedicated for managing the power of the whole chip.
>>
>> 1. add pd node for RK3399 Soc
>> 2. create power domain tree
>> 3. add qos node for domain
>>
>>  From the DT/binds and driver can get more detail information:
>> The driver:
>>          drivers/soc/rockchip/pm_domains.c
>> The document:
>>          Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>> ---
> Everything from here to the actual diff will omitted by tools like git-am...

Hmm....

I think the '---' cause the broken with patman tool.

Thanks,
Caesar
>
>> Changes in v2:
>> - As Doug/Heiko commnets on https://patchwork.kernel.org/patch/9206415/.
>>    drop the debugfs-dump and Add the comments for alphabetical order.
>>
>> Note: As the TRM lists many voltage domains and power domains, then
>> in actual we just need control some domains for driver.
>> Due to some domains (e.g. emmc, usb, core)...We can't turn off it on
>> bootup.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-rockchip at lists.infradead.org
>> Cc: Heiko Stuebner <heiko@sntech.de>
>>
> ...but you have your S-o-B and collected tags here so these are going
> to be stripped. You should move those before the first '---'
> separator.
> Best regards,
> Javier
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
caesar wang | software engineer | wxt at rock-chip.com
