From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 24 Jan 2014 14:37:59 +0530
Subject: [PATCH 2/2] clk: exynos4: Fix spacing related checkpatch errors
In-Reply-To: <52DD1182.80200@samsung.com>
References: <1389780070-4959-1-git-send-email-sachin.kamat@linaro.org>
 <1389780070-4959-2-git-send-email-sachin.kamat@linaro.org>
 <52DD1182.80200@samsung.com>
Message-ID: <CAK9yfHwx+8=xr8=95UJmewO-rtydhqP7s5bzayDwNULPrir5Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 20 January 2014 17:37, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Sachin,
>
>
> On 15.01.2014 11:01, Sachin Kamat wrote:
>>
>> Silences the following type of checkpatch errors:
>> ERROR: space prohibited after that open parenthesis '('
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>   drivers/clk/samsung/clk-exynos4.c |   50
>> ++++++++++++++++++-------------------
>>   1 file changed, 25 insertions(+), 25 deletions(-)
>
>
> I believe this is a false warning. In this special case the spaces greatly
> improve readability of static data in the driver, which I believe is
> preferred over the strict rules of checkpatch.

I agree that the existing pattern looks good to eyes :)
But then you will keep getting many such fix patches. The intention was to
bring this to your notice.
What say about the other patch in this series?

-- 
With warm regards,
Sachin
