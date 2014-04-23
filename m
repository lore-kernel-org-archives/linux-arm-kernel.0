From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 23 Apr 2014 16:30:31 +0900
Subject: [PATCHv2] pinctrl: exynos: Add driver data for Exynos3250
In-Reply-To: <CACRpkdaycY=Mba1pYQMv-Yq87JGfyJEnwmrT+qwDhrZ_4Rqs+g@mail.gmail.com>
References: <1397439947-31592-1-git-send-email-cw00.choi@samsung.com>
 <CACRpkdaycY=Mba1pYQMv-Yq87JGfyJEnwmrT+qwDhrZ_4Rqs+g@mail.gmail.com>
Message-ID: <53576C17.5000601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 04:01 PM, Linus Walleij wrote:
> On Mon, Apr 14, 2014 at 3:45 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>> From: Tomasz Figa <t.figa@samsung.com>
>>
>> This patch adds driver data (bank list and EINT layout) for Exynos3250
>> to pinctrl-exynos driver. Exynos3250 includes 158 multi-functional input/output
>> ports. There are 23 general port groups.
>>
>> Changes from v1:
>> - Add signed-off of sender
>> - Post only separated patch for pinctrl from following patchset(v1)
>>   : https://lkml.org/lkml/2014/4/10/286
>>
>> Cc: Thomas Abraham <thomas.abraham@linaro.org>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> This v2 patch applied.
> 

Thanks for your apply.

Best regards,
Chanwoo Choi
