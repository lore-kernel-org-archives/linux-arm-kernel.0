From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 10 Apr 2014 21:17:46 +0200
Subject: [PATCH 08/27] pinctrl: exynos: Add driver data for Exynos3250
In-Reply-To: <CACRpkdYiFCHFifkpRwDhdAGqBrGTU5E4mfdGE8u1c=zrim17aA@mail.gmail.com>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>	<1397122124-15690-9-git-send-email-cw00.choi@samsung.com>
 <CACRpkdYiFCHFifkpRwDhdAGqBrGTU5E4mfdGE8u1c=zrim17aA@mail.gmail.com>
Message-ID: <5346EE5A.3070408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10.04.2014 20:42, Linus Walleij wrote:
> On Thu, Apr 10, 2014 at 11:28 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
>> From: Tomasz Figa <t.figa@samsung.com>
>>
>> This patch adds driver data (bank list and EINT layout) for Exynos3250
>> to pinctrl-exynos driver. Exynos3250 includes 158 multi-functional input/output
>> ports. There are 23 general port groups.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Ugh can Tomasz send out his patches himself, I get confused...
> It was also sent two times, the second time with CC:s added.
> Tomasz, shall I merge this?

I'm fine with this patch being sent by Chanwoo, although he should have 
probably added his sign-off to the list, as the person sending it.

Chanwoo, can you make sure that there is your sign-off on all the 
patches from this series?

Best regards,
Tomasz
