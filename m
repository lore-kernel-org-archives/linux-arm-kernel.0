From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 30 Sep 2014 17:25:25 +0800
Subject: [PATCH v2 1/3] i2c: hix5hd2: add devicetree documentation
In-Reply-To: <2135291.ciFUCkAm4U@wuerfel>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org>
 <1411878129-19743-2-git-send-email-zhangfei.gao@linaro.org>
 <2135291.ciFUCkAm4U@wuerfel>
Message-ID: <542A7705.2030404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/30/2014 05:01 PM, Arnd Bergmann wrote:
> On Sunday 28 September 2014 12:22:07 Zhangfei Gao wrote:
>> +
>> +Required properties:
>> +- compatible: Must be "hisilicon,hix5hd2-i2c"
>> +  Specifically, the following versions of the chipset are supported:
>> +         Hi3716CV200 (support six I2C module)
>> +         Hi3719CV100 (support six I2C module)
>> +         Hi3718CV100 (support six I2C module)
>> +         Hi3719MV100 (support two I2C module)
>> +         Hi3718MV100 (support two I2C module)
>>
>
> How do you detect the specific model? Is there a hardware register that
> lets you know the type?
> If you have a device specific "compatible" string, you should list all
> the known strings.
>
In fact, no need to distinguish these hardware, the only difference is 
i2c module number.
The same compatible is used.
These info can be removed to remove the confusion.

Thanks
