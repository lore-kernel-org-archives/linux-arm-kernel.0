From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 18 Dec 2013 23:39:58 +0530
Subject: [PATCH 2/3] clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
In-Reply-To: <2996623.YXg5JqReYS@flatron>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
 <1383905648-23733-2-git-send-email-sachin.kamat@linaro.org>
 <2996623.YXg5JqReYS@flatron>
Message-ID: <CAK9yfHzs+T0g0qy-EALFkrKFybdJDAQ3ZGAoYovZO8PDaWM4QA@mail.gmail.com>
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
>
> I guess you are sure about this, so:
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

I believe you are going to take this through your tree along with a
few others which you have already reviewed?

-- 
With warm regards,
Sachin
