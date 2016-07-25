From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Mon, 25 Jul 2016 10:00:21 +0800
Subject: [RFC PATCH v1 0/2] Add Hisilicon Djtag driver
In-Reply-To: <20160722105648.GD17584@leverpostej>
References: <1469177332-72156-1-git-send-email-tanxiaojun@huawei.com>
 <20160722105648.GD17584@leverpostej>
Message-ID: <579572B5.5080108@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/7/22 18:56, Mark Rutland wrote:
> Hi,
> 
> I understand that some SoC/socket level PMU is accessed via these
> registers. It doesn't make sense to review either in isolation. Please
> put together a unified series, with both the djtag accessors and the
> PMU code.
> 
> On it's own, it's *very* difficult to understand how this fits into the
> SoC, and how it is to be used.
> 
> Thanks,
> Mark.
> 

OK. Thank you for your suggestion. I need to think about it again.

Thanks,
Xiaojun.

> On Fri, Jul 22, 2016 at 04:48:50PM +0800, Tan Xiaojun wrote:
>>
>> Tan Xiaojun (2):
>>   Documentation: arm64: Add Hisilicon HiP05/06/07 Sysctrl and Djtag dts
>>     bindings
>>   drivers: soc: Add support for Hisilicon Djtag driver
>>
>>  .../bindings/arm/hisilicon/hisilicon.txt           |   98 +++++
>>  drivers/soc/Kconfig                                |    1 +
>>  drivers/soc/Makefile                               |    1 +
>>  drivers/soc/hisilicon/Kconfig                      |   12 +
>>  drivers/soc/hisilicon/Makefile                     |    1 +
>>  drivers/soc/hisilicon/djtag.c                      |  373 ++++++++++++++++++++
>>  include/linux/soc/hisilicon/djtag.h                |   18 +
>>  7 files changed, 504 insertions(+)
>>  create mode 100644 drivers/soc/hisilicon/Kconfig
>>  create mode 100644 drivers/soc/hisilicon/Makefile
>>  create mode 100644 drivers/soc/hisilicon/djtag.c
>>  create mode 100644 include/linux/soc/hisilicon/djtag.h
>>
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> .
> 
