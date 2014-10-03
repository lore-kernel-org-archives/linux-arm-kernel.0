From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 03 Oct 2014 21:15:07 +0800
Subject: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <20141003120926.GF1349@katana>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org>
 <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org>
 <20141003120926.GF1349@katana>
Message-ID: <542EA15B.70605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/03/2014 08:09 PM, Wolfram Sang wrote:
> Hi,
>
> On Tue, Sep 30, 2014 at 08:20:27PM +0800, Zhangfei Gao wrote:
>> From: Wei Yan <sledge.yanwei@huawei.com>
>>
>> I2C drivers for hix5hd2 soc series, including following chipset
>> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
>>
>> Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Looks good to me. You probably want to have a look at this patch
> http://patchwork.ozlabs.org/patch/394648/
>
> an do something similar here, I guess.
>
> BTW what tests have you performed?
>

Thanks Wolfram for the info, will update accordingly.

Currently Wei help do the test via I2C device interface, on a specific 
board with i2c device.
We do the test after the board is up, also no i2c activity during probe.

Thanks
