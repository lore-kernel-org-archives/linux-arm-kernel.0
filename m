From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 04 Sep 2014 14:22:36 -0700
Subject: [PATCH] mmc: sdhci-msm: Make tuning block table endian agnostic
In-Reply-To: <CAPDyKFp0LwK=DABHaP-Ke=QZFP8bY5MO9RnYmUBqeEdDKp63BA@mail.gmail.com>
References: <1409752622-7564-1-git-send-email-sboyd@codeaurora.org>	<5407F364.9030303@samsung.com>
 <CAPDyKFp0LwK=DABHaP-Ke=QZFP8bY5MO9RnYmUBqeEdDKp63BA@mail.gmail.com>
Message-ID: <5408D81C.7070602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/14 03:53, Ulf Hansson wrote:
> On 4 September 2014 07:06, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>
>> In dw-mmc.c, tuning_block values are same.
>> So I think we can move these value into generic header. how about?
> Actually, I believe these values comes from the eMMC specification?
> Shouldn't they be moved to the mmc core instead?

That sounds like good consolidation, but can we do that in a follow-up
patch? This fixes the driver for me and I was hoping to make something
minimal to go back to stable trees.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
