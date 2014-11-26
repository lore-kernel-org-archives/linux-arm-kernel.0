From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 27 Nov 2014 02:56:52 +0900
Subject: [RESEND PATCH 1/2] ARM: dts: exynos4x12: Device tree node
 definition for TMU on Exynos4x12
In-Reply-To: <20141124094926.04ffacfd@amdc2363>
References: <1416474343-1283-1-git-send-email-l.majewski@samsung.com>
 <035001d005fd$7abac670$70305350$@kernel.org>
 <20141124094926.04ffacfd@amdc2363>
Message-ID: <54761464.2080005@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/14 17:49, Lukasz Majewski wrote:
> Hi Kukjin,
> 
>> Lukasz Majewski wrote:
>>>
>> + Bart, Tomasz and MLs
>>
>> Hi Lukasz,
>>
>> Please post including MLs, even resending.
>>
>> Will apply for v3.19, and just note that you asked me to apply this
>> for 3.18 in personal talk but I couldn't see any requirements for
>> fixes-3.18. If I'm missing something, please let me know.
> 
> The thing is that by default Exynos 4412 (trats2) can run with modified
> cpufreq to support SW governed overclocking (BOOST).
> 
> To provide safe BOOST operation, TMU (thermal) _must_ be configured.
> Configuration is not possible when trats2 DTS lacks of those patches.
> 
Well, AFAIK the BOOST mode is only available on only Samsung mobile not
mainline and so I think this is not for bug fix in mainline for 3.18...

- Kukjin

> So, yes there is a requirement to add those patches to v3.18 (if not
> possible please add it to v3.19).
> 
>>
>> Thanks,
>> Kukjin
>>
>>> The TMU device tree node definition for Exynos4x12 family of SoCs.
>>>
>>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/exynos4x12.dtsi | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
