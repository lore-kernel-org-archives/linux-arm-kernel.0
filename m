From: caesar.upstream@gmail.com (Caesar Wang)
Date: Sat, 07 Nov 2015 23:47:45 +0800
Subject: [PATCH v2 0/9] Better compatible for the rockchip thermal and
 support RK3368 SoCs
In-Reply-To: <20151106184739.GA8202@localhost.localdomain>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <20151106184739.GA8202@localhost.localdomain>
Message-ID: <563E1D21.8030502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

? 2015?11?07? 02:47, Eduardo Valentin ??:
> Caesar,
>
> On Thu, Nov 05, 2015 at 01:17:56PM +0800, Caesar Wang wrote:
>> This series patchs are working for RK3368 on Rockchip platform.
>>
> Good to see the perseverance! :-)

I will send th patch [4-6]  next version and another pacth(fix the long 
temp->int temp) on tomorrow.
Need the verify it on my board firstly.:-P


>
>> @Heiko,
>>      The PATCH [5/6] is working based on big/littel cluster cpufreq
>>      added. Anyway, the PATCH [5/6] also work for next kernel.
>>
>> @Eduardo,
>> This patchset are based on linus master branch.
>> Note: Need add the following thermal patchs for thermal driver before apply
>> this series patchs.
>>
>> 1) thermal: rockchip: fix handling of invalid readings
>> (https://patchwork.kernel.org/patch/6973101/)
>>
>> 2) thermal: rockhip: fix setting thermal shutdown polarity
>> (https://patchwork.kernel.org/patch/6973131/)
>>
>> 3) dt-bindings: rockchip-thermal: Add the pinctrl states in this document
>> (https://patchwork.kernel.org/patch/7472021/)
>>
>> 4) thermal: rockchip: support the sleep pinctrl state to avoid glitches in s2r
>> (https://patchwork.kernel.org/patch/7472051/)
>>
>> I'm glad these patchs have merged in thermal-soc git tree which can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> Yeah, apologize the delay on giving you a feedback on your code. As I
> mentioned before, I had a couple of other things in past weeks that
> consumed my time.

I see, that have been a very response from you.
Thank you taking your time to review this series patchs.:-)


> Anyways, this specific patch series looks way better now that you have
> split it further. I will have a better look on it again and let you
> know when it will land.

Many thank again.

> BR,
>
> Eduardo Valentin
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
