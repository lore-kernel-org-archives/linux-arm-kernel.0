From: john.stultz@linaro.org (John Stultz)
Date: Mon, 14 Oct 2013 13:18:32 -0700
Subject: [PATCH v4 05/17] arch_timer: Move to generic sched_clock framework
In-Reply-To: <87ob6r625t.fsf@linaro.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-6-git-send-email-sboyd@codeaurora.org>
 <87k3hf7kvb.fsf@linaro.org> <525C3E2F.2030109@codeaurora.org>
 <87ob6r625t.fsf@linaro.org>
Message-ID: <CALAqxLWVWZ+BGhDOMOAGLF6uE+xN9wkMYpxyoa7JGn7d2Djmxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 1:14 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
>
>> Can you try this patch?
>
> Yup, your patch gets it booting again.
>
> John, how do you want to proceed on this?  The version of $SUBJECT patch
> that made it to -next doesn't match the one in sent in this thread.

We'll need to get the fix applied to -tip, where my mis-merge landed.

thanks
-john
