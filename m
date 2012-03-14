From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 14:37:45 +0000
Subject: [PATCH 02/10] ARM: ux500: Initial Device Tree support for Snowball
In-Reply-To: <201203141358.03541.arnd@arndb.de>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-3-git-send-email-lee.jones@linaro.org>
 <201203141358.03541.arnd@arndb.de>
Message-ID: <4F60AD39.6020009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/12 13:58, Arnd Bergmann wrote:
> On Wednesday 14 March 2012, Lee Jones wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This provides very basic Device Tree support for ST-Ericsson's
>> low-cost development platform, Snowball. If Device Tree for
>> ux500 is enabled and the correct board is configured within the
>> Device Tree blob, the correct *_init_machine() will be called.
>>
>> This patch is based on some original work completed by:
>>   Niklas Hernaeus <niklas.hernaeus@linaro.org>
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> 
> As mentioned on IRC, the order of the S-o-B should be such that the
> person submitting a patch comes last, so this one should be
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> or maybe
> 
> Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Sorry I missed that.

Just for my clarification, how important is that?

Is it re-spin a patch-set important?

> The patch itself looks good to me, but that is not surprising,
> given that I wrote it ;-).


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
