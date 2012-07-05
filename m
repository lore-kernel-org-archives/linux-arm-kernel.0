From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 14:55:33 +0100
Subject: [PATCH 3/9] ARM: ux500: Remove AB8500 regulator register
 initialisation information
In-Reply-To: <201207051351.03115.arnd@arndb.de>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-4-git-send-email-lee.jones@linaro.org>
 <201207051351.03115.arnd@arndb.de>
Message-ID: <4FF59CD5.3030007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 14:51, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Lee Jones wrote:
>> There is no need to initialise the AB8500's regulator registers, as
>> most of this work is already carried out by framework features, so
>> we can safely remove all traces from platform code.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> It makes sense, but this patch is basically a revert of dfa3a824d
> "mach-ux500: provide ab8500 init vector" from Bengt Jonsson, so
> it would be nice to get an Ack from him.

Good idea.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
