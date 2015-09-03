From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 03 Sep 2015 11:55:14 +0800
Subject: [PATCH v4 03/16] drm: bridge: analogix/dp: split exynos dp driver
 to bridge dir
In-Reply-To: <CACvgo53pZUtSLRGVMYPs1s4QPBrAr3j=xoZ1t23tPv202bzfyg@mail.gmail.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>	<1441086598-24995-1-git-send-email-ykk@rock-chips.com>
 <CACvgo53pZUtSLRGVMYPs1s4QPBrAr3j=xoZ1t23tPv202bzfyg@mail.gmail.com>
Message-ID: <55E7C4A2.6000504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emil,

? 09/02/2015 10:50 PM, Emil Velikov ??:
> [Dropping the CC list]

Hmm...Don't understand what this means. If you can explain, that
would be better, so I would not miss your suggest.  :-)

> Hi Yakir Yang,
>
> On 1 September 2015 at 06:49, Yakir Yang <ykk@rock-chips.com> wrote:
>> Split the dp core driver from exynos directory to bridge
>> directory, and rename the core driver to analogix_dp_*,
>> leave the platform code to analogix_dp-exynos.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v4:
>> - Take Rob suggest, update "analogix,hpd-gpios" to "hpd-gpios" DT propery.
>> - Take Jingoo suggest, rename "analogix_dp-exynos.c" file name to "exynos_dp.c"
>> - Take Archit suggest, create a separate folder for analogix code in bridge/
>>
> "Take X suggest", is grammatically incorrect. You should use
> "suggestion(s)" or alternatively use the following approach.
>
> - Create a separate folder for analogix code in bridge/ (Archit)

Thanks for your correct. I prefer to take the last one  ;)

> Cheers,
> Emil
>
> P.S. Why do you resend the whole series (some 10+ patches) when only a
> few patches have been changed ? Are all the patches changed whist
> missing that information (vX: rebase on top of A)

Yes, those 10+ patches do base on the previous changes, specially when I
rebase my series on the latest linux-next branch.

Besides, I don't know that how to send parts of this series, and keep the
unrelated patches no send. For example if the [v4 03/16] ~ [v4 10/16]
need  update to v5, and [v4 11/16] ~ [v4 16/16] keep in v4.
So should I only send the [v5 03/16]  ~ [v5 10/16], no need to send and
update [v4 11/16] ~ [v4 16/16] to v5 ?

If so I think it would be difficult for guys to comment, cause they 
can't see
the whole series in one reply list .   ;)

Thanks,
- Yakir
>
>
