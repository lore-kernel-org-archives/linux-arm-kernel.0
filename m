From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 14 Mar 2013 17:49:22 +0800
Subject: [PATCH v4 2/5] clk: hi3xxx: add clock support
In-Reply-To: <201303140909.21267.arnd@arndb.de>
References: <1363245584-24488-1-git-send-email-haojian.zhuang@linaro.org>
 <1363245584-24488-3-git-send-email-haojian.zhuang@linaro.org>
 <201303140909.21267.arnd@arndb.de>
Message-ID: <CAD6h2NT8MjT_ZX3kd_ed5gs_K_bEBHXpaQDxyb0KHaBsPn7fRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2013 17:09, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 14 March 2013, Haojian Zhuang wrote:
>>
>> Add clock support with device tree on Hisilicon SoC.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> Looks good to me, just one final comment from my side:
>
>> +
>> +static struct hs_clk hs_clk;
>> +
>> +static void __init hs_init_clocks(void);
>> +
>
> Please move the hs_init_clocks() function itself to the top of the file to
> avoid the forward declaration.
>
>         Arnd

No problem.

Regards
Haojian
