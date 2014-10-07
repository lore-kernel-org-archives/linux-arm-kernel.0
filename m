From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 07 Oct 2014 08:45:09 +0800
Subject: [PATCH v4 2/3] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <20141006175611.GB2000@katana>
References: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
 <1412350549-2607-3-git-send-email-zhangfei.gao@linaro.org>
 <20141006175611.GB2000@katana>
Message-ID: <54333795.8010707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/2014 01:56 AM, Wolfram Sang wrote:
> On Fri, Oct 03, 2014 at 11:35:48PM +0800, Zhangfei Gao wrote:
>> From: Wei Yan <sledge.yanwei@huawei.com>
>>
>> I2C drivers for hix5hd2 soc series, including following chipset
>> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
>>
>> Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Sorry, one more thing, then we are ready to go:
>
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>
> Here you say "GPL v2 or later"...
>
>> +MODULE_LICENSE("GPL v2");
>
> ... here "GPL v2 only". That should be consistent!

Thanks for the notifying this, not notice before.
Should change to MODULE_LICENSE("GPL").

include/linux/module.h

/*
  * The following license idents are currently accepted as indicating free
  * software modules
  *
  *      "GPL"                           [GNU Public License v2 or later]
  *      "GPL v2"                        [GNU Public License v2]
  *      "GPL and additional rights"     [GNU Public License v2 rights 
and more]
  *      "Dual BSD/GPL"                  [GNU Public License v2
  *                                       or BSD license choice]
  *      "Dual MIT/GPL"                  [GNU Public License v2
  *                                       or MIT license choice]
  *      "Dual MPL/GPL"                  [GNU Public License v2
  *                                       or Mozilla license choice]
  *

Thanks
