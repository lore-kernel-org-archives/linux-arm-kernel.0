From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 03 Feb 2015 23:26:46 +0100
Subject: [PATCH] ARM: berlin: add a defconfig
In-Reply-To: <3962783.sVjmOB1hYm@wuerfel>
References: <1422962932-12603-1-git-send-email-antoine.tenart@free-electrons.com>
 <3962783.sVjmOB1hYm@wuerfel>
Message-ID: <54D14B26.4050406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.02.2015 13:54, Arnd Bergmann wrote:
> On Tuesday 03 February 2015 12:28:52 Antoine Tenart wrote:
>> Marvell Berlin SoCs did not have a custom defconfig and were only
>> supported in multi_v7_defconfig.
>>
>> Adds a proper defconfig, allowing to boot a Berlin SoC with all the
>> currently supported features: SMP, Pinmux, AHCI, Ethernet, I2C, GPIO,
>> USB, SDHCI.
>>
>>
>
> Are there any features that are not currently supported by
> multi_v7_defconfig? If so, please also add them there as
> loadable modules.

Antoine, Arnd,

do we really need two potentially diverging defconfigs?

I am aware that multi_v7_defconfig adds a lot of stuff that is
not required for Berlin, but still I think in terms of coverage
(both Berlin and non-Berlin stuff) multi_v7 is sufficient, isn't
it?

However, if there is a strong desire for Berlin-only defconfig,
I'll agree.

Sebastian
