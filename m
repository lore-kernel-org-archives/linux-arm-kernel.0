From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 2 Jan 2015 11:28:48 +0100
Subject: [PATCH v5 0/4] Fixes for SDIO interrupts for dw_mmc
In-Reply-To: <CAPDyKFqGW2NaN+5mUrpBWrhM5ZfUSx70-Yyk9qmNaC1ft_ibpw@mail.gmail.com>
References: <1417563767-32181-1-git-send-email-dianders@chromium.org>
 <CAPDyKFpxvE4x_-PV=KN0HKY5cNug-ss9m5KCjNdebR1LDOJi5w@mail.gmail.com>
 <CAD=FV=UCyOXfMqu_MYbd5pKOpgXPB87LQ7hCegeeY9vzsy6QAg@mail.gmail.com>
 <CAPDyKFqGW2NaN+5mUrpBWrhM5ZfUSx70-Yyk9qmNaC1ft_ibpw@mail.gmail.com>
Message-ID: <CABxcv==1w1GAHNCaNnh+e-xaYo8xtuD8dywTseioosxT4GZOvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Tue, Dec 30, 2014 at 11:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 19 December 2014 at 20:02, Doug Anderson <dianders@chromium.org> wrote:
>>
>>> It was a bit hard to follow the
>>> updated the revisions, please don't send patches "in-reply-to" for
>>> future sets.
>>
>> Very strange.  I didn't send out anything in-reply-to other than what
>> git-send-email usually does.  I believe I had:
>>
>> [0] - no in reply to.
>>  [1] - in reply to [0]
>>  [2] - in reply to [0]
>>  [3] - in reply to [0]
>>  [4] - in reply to [0]
>
> That's good. As long as there are no in-reply to previous versions of
> patches/patchsets.
>
> I am using gmails web-based client so it could very well be that it
> does some magic, which I am not yet aware of.
>

I think that you were confused because Gmail's "conversation view"
groups emails in a thread not by the email subject but by the email
body.

So if a new revision of a series is sent and a patch did not change
from the previous version, Gmail will add it to the old patch thread
since the body is basically the same even when a version is present in
the subject (e.g: PATCH v2 foo).

I found that annoying as well so I disabled conversation view going to
Gmail's settings -> General -> Conversation view off

Hope it helps.

Best regards,
Javier
