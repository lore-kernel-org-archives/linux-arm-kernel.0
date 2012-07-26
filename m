From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 16:17:08 +0100
Subject: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <20120726151404.GP3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <50114D71.9060700@linaro.org>
 <20120726142825.GK3099@opensource.wolfsonmicro.com>
 <50115BBA.2020400@linaro.org>
 <20120726151404.GP3099@opensource.wolfsonmicro.com>
Message-ID: <50115F74.2040706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 16:14, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 04:01:14PM +0100, Lee Jones wrote:
>
>> This is the only value which the user can pick an obscure value,
>> such as 913, thinking they can pick 913mV. I'm happy to fall-back,
>> as long as Ola is too.
>
> Erroring out if they pick an invalid value is fine, I'm more concerned
> with the case where no property is supplied at all.

Hmmm... I'll have a think.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
