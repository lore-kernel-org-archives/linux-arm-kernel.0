From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 14 Jan 2014 19:52:27 +0800
Subject: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
In-Reply-To: <002a01cf1115$19f6bde0$4de439a0$%jun@samsung.com>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org>
 <002a01cf1115$19f6bde0$4de439a0$%jun@samsung.com>
Message-ID: <52D524FB.2050903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/14/2014 06:40 PM, Seungwon Jeon wrote:
> On Mon, January 13, 2014, Zhangfei Gao wrote:
>> Suggest by Arnd: abstract mmc tuning as clock behavior,
>> also because different soc have different tuning method and registers.
>> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> I add my ack.
> Please run 'checkpatch' and remove some warnings.
> 
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 

Thanks Seungwon.

Have checked before, and ignoring warnings of "line over 80 characters"
seems more neat.

Thanks
