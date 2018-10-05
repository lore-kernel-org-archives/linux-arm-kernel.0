From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Fri, 5 Oct 2018 10:12:10 +0200
Subject: [PATCH] nvmem: lpc18xx_eeprom: fix compile warning
In-Reply-To: <cbd5708c-e06a-acfd-80af-34222bc2be1f@linaro.org>
References: <20181005070313.GA2217@embeddedor.com>
 <cbd5708c-e06a-acfd-80af-34222bc2be1f@linaro.org>
Message-ID: <b9d48751-13eb-0fbe-0bd7-12578816799b@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/5/18 10:06 AM, Srinivas Kandagatla wrote:
> 
> 
> On 05/10/18 08:03, Gustavo A. R. Silva wrote:
>> Fix the following warning by removing unused variable ret:
>>
>> drivers/nvmem/lpc18xx_eeprom.c: In function ?lpc18xx_eeprom_remove?:
>> drivers/nvmem/lpc18xx_eeprom.c:258:6: warning: unused variable ?ret?
>> [-Wunused-variable]
>> ?? int ret;
>> ?????? ^~~
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> There is already a patch submitted fix this
> 
> ?https://lore.kernel.org/patchwork/patch/995032/
> 

Oh, good to know.

Thanks, Srini.
--
Gustavo
