From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 12:52:02 +0200
Subject: [PATCH v7 3/3] ARM: dts: add dts files for xyref5260 board
In-Reply-To: <CAK9yfHwWh9sFivsg-P9wT6DXM2J3nYuHqzgfwuo_Go7S-vriVA@mail.gmail.com>
References: <1396519224-18712-1-git-send-email-rahul.sharma@samsung.com>
 <1396519224-18712-4-git-send-email-rahul.sharma@samsung.com>
 <CAK9yfHwWh9sFivsg-P9wT6DXM2J3nYuHqzgfwuo_Go7S-vriVA@mail.gmail.com>
Message-ID: <53452652.7040304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.04.2014 10:40, Sachin Kamat wrote:
> On 3 April 2014 15:30, Rahul Sharma <rahul.sharma@samsung.com> wrote:
>> The patch adds the dts files for xyref5260 board which
>> is based on Exynos5260 Evt0 sample.
>>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> ---
>
>> +/ {
>> +       model = "SAMSUNG XYREF5260 EVT0 board based on EXYNOS5260";
>> +       compatible = "samsung,xyref5260", "samsung,exynos5260";
>
> "samsung,exynos5260" is OK here for future compatibility (if soc
> specific quirk is required).
> Please also add "samsung,exynos5" to compatible list.
>

Right. SoC family compatible string should be added between board and 
SoC model strings.

Best regards,
Tomasz
