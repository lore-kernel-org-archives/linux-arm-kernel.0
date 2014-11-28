From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 28 Nov 2014 13:07:03 +0100
Subject: [PATCH v3 3/5] pinctrl: exynos: add exynos5410 SoC specific data
In-Reply-To: <CACRpkdZie8JJGxSPkc8PPvC3qZkWhe5WqmpSKSoDFwqRd6tR_Q@mail.gmail.com>
References: <547104D5.4030803@suse.de>	<1416695185-5198-1-git-send-email-afaerber@suse.de>
 <CACRpkdZie8JJGxSPkc8PPvC3qZkWhe5WqmpSKSoDFwqRd6tR_Q@mail.gmail.com>
Message-ID: <54786567.4050305@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.11.2014 um 12:59 schrieb Linus Walleij:
> On Sat, Nov 22, 2014 at 11:26 PM, Andreas F?rber <afaerber@suse.de> wrote:
> 
>> From: Hakjoo Kim <ruppi.kim@hardkernel.com>
>>
>> Add Samsung EXYNOS5410 SoC specific data to enable pinctrl
>> support for all platforms based on EXYNOS5410.
>>
>> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
>> [AF: Rebased onto Exynos5260 and irq_chip consolidation]
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v2 -> v3:
>>  * Rebased (.svc, .{g,w}eint_{con,mask,pend} fields dropped)
>>
>>  v1 -> v2:
>>  * Filled in Sob from Hakjoo Kim
> 
> Is this based on the pinctrl devel branch so I can apply it?

It was based on the Samsung for-next tree. I can rebase if needed.

> I'd like Tomasz ACK on it first though.

Thanks,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
