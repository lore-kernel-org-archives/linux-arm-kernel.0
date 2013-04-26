From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 26 Apr 2013 13:39:09 -0700
Subject: [PATCH V3] ARM: KVM: Allow host virtual timer irq number to be
 different from guest virtual timer irq number
In-Reply-To: <CAAhSdy0ZoN_3gyVLLbK6bVr8OJMyO1r3uLYe4S1v9PV7nWvNDQ@mail.gmail.com>
References: <1366982847-11028-1-git-send-email-anup.patel@linaro.org>
 <517A8560.6070005@arm.com>
 <CAAhSdy3XVRVp62xeuPp6Dum1OwvgmF1UKqwTqABUp71WS7ronw@mail.gmail.com>
 <CAEDV+g+a7zVnGBKJT9c+B_tiO8PEy-J2CQBWOxznMMrY1bDSOw@mail.gmail.com>
 <CAAhSdy0ZoN_3gyVLLbK6bVr8OJMyO1r3uLYe4S1v9PV7nWvNDQ@mail.gmail.com>
Message-ID: <CAEDV+gLfG9Yb8rexSbO9o9=Ef7wxCd7i2CSeFuspGiH4KpRwww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 12:11 PM, Anup Patel <anup@brainfault.org> wrote:
> On Fri, Apr 26, 2013 at 11:57 PM, Christoffer Dall
> <cdall@cs.columbia.edu> wrote:
>>>
>>> Sure, I incorporate all above comments and send revised patch.
>>>
>> Hi Anup,
>>
>> Now when we're at it, your commit message is exessively long, both the
>> title and the actual content. Please try to keep the commit message
>> under 80 chars at least and the title of the patch even shorter if
>> possible: think doing a 'git log' on an 80 char terminal...
>>
>> -Christoffer
>
> Oke, I'll keep the commit message shorter.
>
thanks, just to be clear, the body of the message can be as long as
appropriate, but the lines should be wrapped at 80 chars max.
