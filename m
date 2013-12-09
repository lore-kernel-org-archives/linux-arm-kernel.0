From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 9 Dec 2013 21:50:16 +0530
Subject: [PATCH 1/1] clk: exynos5250: Add CLK_SET_RATE_PARENT flag to
 mout_apll
In-Reply-To: <1466487.IbnMiN0f0X@amdc1227>
References: <1385007454-5234-1-git-send-email-sachin.kamat@linaro.org>
 <1466487.IbnMiN0f0X@amdc1227>
Message-ID: <CAK9yfHwwsf7GqZ-7Fc_CwmnHf=A9GN7Dtqve7Woh+khJKr8oDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 9 December 2013 19:01, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Sachin,
>
> On Thursday 21 of November 2013 09:47:34 Sachin Kamat wrote:
>> Add CLK_SET_RATE_PARENT flag to be able to change the frequency
>> to desired value.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/clk/samsung/clk-exynos5250.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Your patch description is a bit off. It doesn't say frequency of what
> clock will be able to be changed to "desired value" and what is the reason
> for this change.

Yes, I realize that now. Will update and resend. Thanks for review.

-- 
With warm regards,
Sachin
