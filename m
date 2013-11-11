From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 11 Nov 2013 08:41:57 +0530
Subject: [PATCH 2/3] clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
In-Reply-To: <2996623.YXg5JqReYS@flatron>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
 <1383905648-23733-2-git-send-email-sachin.kamat@linaro.org>
 <2996623.YXg5JqReYS@flatron>
Message-ID: <CAK9yfHy+K66PZM2sjZqqxZjgkd9sZC=WyqGL8yiHL3tpQ_MO7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 10 November 2013 22:38, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Sachin, Andrew,
>
> On Friday 08 of November 2013 15:44:07 Sachin Kamat wrote:
>> From: Andrew Bresticker <abrestic@chromium.org>
>>
>> The gate clocks for the MFC sysmmus appear to be flipped, i.e.
>> GATE_IP_MFC[2] gates sysmmu_mfcl and GATE_IP_MFC[1] gates sysmmu_mfcr.
>> Fix this so that the MFC will start up.
>
> Wow, this means that there is a mistake in the documentation. Not that
> I'm surprised, though.

Yes, there is a mistake in the TRM in this case.

>
> I guess you are sure about this, so:
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Thanks.

-- 
With warm regards,
Sachin
