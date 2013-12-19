From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Wed, 18 Dec 2013 17:27:49 -0800
Subject: [PATCH 1/2] gpio: msm: Fix irq mask/unmask by writing bits instead
 of numbers
In-Reply-To: <CACRpkdY8W8tGVH-Os5neeFfHWjojdB5fBbjgWcsWkiMyJj=YAA@mail.gmail.com>
References: <1386717544-478-1-git-send-email-sboyd@codeaurora.org>
 <CACRpkdY8W8tGVH-Os5neeFfHWjojdB5fBbjgWcsWkiMyJj=YAA@mail.gmail.com>
Message-ID: <52B24B95.8010004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 11:02 AM, Linus Walleij wrote:
> On Wed, Dec 11, 2013 at 12:19 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> We should be writing bits here but instead we're writing the
>> numbers that correspond to the bits we want to write. Fix it by
>> wrapping the numbers in the BIT() macro. This fixes gpios acting
>> as interrupts.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> I've applied this for fixes and tagged for stable.
> Bj?rn, Rohit: OK?
>
> Yours,
> Linus Walleij
Acked-by: Rohit Vaswani <rvaswani@codeaurora.org>

Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
