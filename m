From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Jun 2013 10:14:28 -0700
Subject: [PATCH] gpio: msm-v1: Remove errant __devinit to fix compile
In-Reply-To: <CACRpkdZ5x3q9tn3J5_mQj-nJ_wO3HWgX5DTMQdMzF3mUDrAieQ@mail.gmail.com>
References: <1370373600-31921-1-git-send-email-sboyd@codeaurora.org>
 <CACRpkdZ5x3q9tn3J5_mQj-nJ_wO3HWgX5DTMQdMzF3mUDrAieQ@mail.gmail.com>
Message-ID: <51BF43F4.9000007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/13 22:54, Linus Walleij wrote:
> On Tue, Jun 4, 2013 at 9:20 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> Commit 7bce696 (gpio: Make gpio-msm-v1 into a platform driver,
>> 2013-03-04) was based on an older kernel where __devinit still
>> existed. Remove the erroneous __devinit marking.
>>
>> Cc: David Brown <davidb@codeaurora.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Patch applied.
>
>

Thanks. It looks like David picked this up and sent it off to arm-soc
last week. Cc'ing Olof for awareness of a possible duplicate.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
