From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 02 Jun 2015 22:38:42 +0900
Subject: [PATCH v4 5/5] ARM: dts: Add LEDs to exynos5410-odroidxu
In-Reply-To: <556DA96A.90800@samsung.com>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
 <1426456834-6308-6-git-send-email-afaerber@suse.de>
 <556DA96A.90800@samsung.com>
Message-ID: <556DB1E2.5080607@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.06.2015 um 22:02 schrieb Krzysztof Kozlowski:
> W dniu 16.03.2015 o 07:00, Andreas F?rber pisze:
>> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v2 -> v3: Unchanged
>>  
>>  v1 -> v2:
>>  * Filled in Sob from Hakjoo Kim
>>  
>>  arch/arm/boot/dts/exynos5410-odroidxu.dts | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
> 
> What is the rationale behind doing this in separate patch, not as part
> of 2/5? You can just add new board DTS with all of its features at once,
> but maybe I am missing something?

This patch depends on the pinctrl driver, 2/5 on nothing.

By keeping it a separate patch it was intended to go in more quickly
(clear fail there ;)) and it's easier to review the actual changes -
squashing is always easier than picking apart.

Thanks for your review! Both me and Ben have follow-ups once this moves
forward.

Kind regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
