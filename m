From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 28 Nov 2013 09:07:11 +0800
Subject: [PATCH v4] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <CAA9_cmd6crfVdeLQhnfWLcJViAwHG=c3V5SDgu9teEd3pfch7A@mail.gmail.com>
References: <1377570010-21870-1-git-send-email-zhangfei.gao@linaro.org>	<1377570010-21870-2-git-send-email-zhangfei.gao@linaro.org>
 <CAA9_cmd6crfVdeLQhnfWLcJViAwHG=c3V5SDgu9teEd3pfch7A@mail.gmail.com>
Message-ID: <5296973F.3070009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dear Dan

On 11/28/2013 06:35 AM, Dan Williams wrote:
> On Mon, Aug 26, 2013 at 7:20 PM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>> Add dmaengine driver for hisilicon k3 platform based on virt_dma
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Kai Yang <jean.yangkai@huawei.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> ---

>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 6825957..2945ff0 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -300,6 +300,15 @@ config DMA_JZ4740
>>          select DMA_ENGINE
>>          select DMA_VIRTUAL_CHANNELS
>>
>> +config K3_DMA
>> +       tristate "Hisilicon K3 DMA support"
>> +       depends on ARCH_HI3xxx
>
> Unless I am missing something this driver cannot be built since
> ARCH_HI3xxx does not exist.  Is this arch still winding its way
> upstream?
>

The patch set "enable hi3xxx SoC" still on the way, suppose to be in 
3.13, including adding ARCH_HI3xxx.

Sorry for the confusion.

Thanks
