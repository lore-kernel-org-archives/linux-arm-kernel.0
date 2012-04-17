From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 16:30:51 +0100
Subject: [PATCH 15/16] ARM: ux500: Apply Device Tree settings for the
 DB8500 PRCMU
In-Reply-To: <201204171447.06520.arnd@arndb.de>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-16-git-send-email-lee.jones@linaro.org>
 <201204171447.06520.arnd@arndb.de>
Message-ID: <4F8D8CAB.5040902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/12 15:47, Arnd Bergmann wrote:
> On Tuesday 17 April 2012, Lee Jones wrote:
>> In this patch we enable the db8500-prcmu via DT and take out
>> any enablement previously carried out by platform code.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> This patch by itself is broken, because it relies on patch 16.
> I suggest merging the two into a single patch to atomically
> move over from the static definition of the prcmu to the
> device tree based definition. You can also combine it with
> patch 14, which by itself is harmless but also pointless.

Not as far as I can tell. This patch relies on 12 and 13. Patch 16 is 
for the PRCMU timer, which is a different entity.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
