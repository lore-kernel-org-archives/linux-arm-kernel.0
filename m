From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 21:27:59 +0800
Subject: [PATCH v5 0/8] enable Hisilicon HIX5HD2 SoC
In-Reply-To: <6493871.xlAJItBgfy@wuerfel>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
 <6493871.xlAJItBgfy@wuerfel>
Message-ID: <CAD6h2NReFUYdydMqNYfE1LbWM_r-5mdT9GOGcj1v2fnzrT=ZAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 July 2014 21:11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 28 July 2014 20:51:15 Haojian Zhuang wrote:
>> Changelog:
>> v5:
>>   * Use CPU_OF_DECLARE_METHOD().
>>   * State "hisilicon,cpuctrl" in documents.
>>   * Set PL310 L2 aux value in machine descriptor.
>>   * Use enable-method property for smp in dts file.
>>   * Move reset code from machine platform driver into power reset driver.
>>   * Move HIP04 debug uart into another patch series.
>
> Looks ok for the most part. I have a trivial comment on patch 8/8,
> please correct that.
>
> The comment on patch 7/8 is more severe. Depending on the hardware
> requirements, this may end up being much harder to fix, but it
> needs some discussion. Adding the values only for hi3620 in the
> meantime should be ok.
>
>         Arnd

OK. I'll remove the l2c aux value of hix5hd2 on patch 7/8. And I'll
use hi3620-smp in patch 8/8.

Regards
Haojian
