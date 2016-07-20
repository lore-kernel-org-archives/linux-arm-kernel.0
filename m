From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Jul 2016 14:47:15 +0930
Subject: [PATCH 2/4] drivers/clocksource/moxart: Refactor enable/disable
In-Reply-To: <20160510130414.GE14952@linaro.org>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
 <1462797169-14512-3-git-send-email-joel@jms.id.au>
 <CACPK8XfJ2e1kr-WftidvqsoYew7LqPiNo0sw7opgh8UH=3q_3A@mail.gmail.com>
 <20160510130414.GE14952@linaro.org>
Message-ID: <CACPK8XdK35p9rxr8et58omvQExjdri20yCq91LGocnPRYpGLQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

On Tue, May 10, 2016 at 10:34 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Tue, May 10, 2016 at 08:36:50PM +0930, Joel Stanley wrote:
>> Hi Daniel,
>>
>> Here's a commit message for this patch. If you'd prefer me to resend
>> the entire series with this included then I can do that.
>
> No, it is ok (except if there are comments on the patches before I merge
> them).

I couldn't find this in your tree. Any chance I could get it merged now?

Cheers,

Joel

>
>> This patch abstracts the enable and disable register writes into their
>> own functions in preparation for future changes to use SoC specific
>> values for the writes.
