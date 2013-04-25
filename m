From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:24:21 +0200
Subject: [PATCH 04/32] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <20130425132025.GM4623@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdaauDYTdoBHGG9FO4kKqvCYyCrjY8EGWs5gAQWErGW6_A@mail.gmail.com>
 <20130425090612.GC4623@gmail.com>
 <CACRpkdbV8yEK0470q_-DWv6Q0hAG2wGntXFi5kaLUMgm9b=e-Q@mail.gmail.com>
 <20130425132025.GM4623@gmail.com>
Message-ID: <CACRpkdbpbQTCxeQ6cCbAkvvQXJMQUhLv8=qcbBgvBVnMDdysOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 3:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 25 Apr 2013, Linus Walleij wrote:

>> As we may want to support DEV_TO_DEV at some point.
>>
>> Then no longer, and that is not related to $SUBJECT.
>
> That's not why I'm removing it. The statement can never be true due to
> the fact that the second evaluation (src_event_group != dst_event_group)
> can never be true, which is a direct effect of 'THIS_PATCH'.

OK that is correct, I'm fine with this then ... as part of that other
patch dealing with unreacable conditions I keep talking about...

Yours,
Linus Walleij
