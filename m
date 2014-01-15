From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 15 Jan 2014 09:40:25 +0800
Subject: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
In-Reply-To: <20140114201740.4167.52076@quantum>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org>
 <20140114201740.4167.52076@quantum>
Message-ID: <52D5E709.7040105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike

On 01/15/2014 04:17 AM, Mike Turquette wrote:
> Quoting Zhangfei Gao (2014-01-13 01:14:28)
>> Suggest by Arnd: abstract mmc tuning as clock behavior,
>> also because different soc have different tuning method and registers.
>> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Patch looks good to me with one exception. I do not have
> Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt in the
> clk-next branch. Is there a stable branch I can pull in as a dependency?

Mach-hisi just have been uploaeded.
Have tried next-20140114, the patch can be applied successfully.
While v3.13-rc8 still can not.

Is this fine?

Thanks
