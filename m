From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 9 Apr 2014 16:10:45 +0530
Subject: [PATCH v6 2/3] ARM: dts: add dts files for exynos5260 SoC
In-Reply-To: <CAK9yfHzBH9rTjJXPMM_OZhnVgpSY1Pj1Ne7Jy-v6zbp8g91zkA@mail.gmail.com>
References: <1396502277-19588-1-git-send-email-rahul.sharma@samsung.com>
 <1396502277-19588-3-git-send-email-rahul.sharma@samsung.com>
 <CAK9yfHzBH9rTjJXPMM_OZhnVgpSY1Pj1Ne7Jy-v6zbp8g91zkA@mail.gmail.com>
Message-ID: <CAK9yfHw+CncWpZ3NEtV7dGhx4LS7Wymw3TAweOXKCU9HShcXsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 April 2014 14:14, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> On 3 April 2014 10:47, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>> The patch adds the dts files for exynos5260.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> ---
> <snip>
>
>> +/ {
>> +       compatible = "samsung,exynos5260";
>
> Add "samsung,exynos5260" to the above list.

Sorry for the typo. Should have been "samsung,exynos5" as mentioned by Tomasz.

-- 
With warm regards,
Sachin
