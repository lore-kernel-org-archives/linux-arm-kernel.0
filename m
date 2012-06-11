From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:37:18 +0100
Subject: [PATCH 01/14] rtc: ab8500-rtc: IRQF_ONESHOT when requesting a
 threaded IRQ
In-Reply-To: <201206111531.20468.arnd@arndb.de>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-2-git-send-email-lee.jones@linaro.org>
 <201206111531.20468.arnd@arndb.de>
Message-ID: <4FD610AE.7010001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 16:31, Arnd Bergmann wrote:
> On Monday 11 June 2012, Lee Jones wrote:
>> The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.
>>
>> Cc: Alessandro Zummo<a.zummo@towertech.it>
>> Cc: rtc-linux at googlegroups.com
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Isn't this a bug fix that should be applied to the stable kernels too?

Possibly. Should we alert Greg (CC'ed - alerted)?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
