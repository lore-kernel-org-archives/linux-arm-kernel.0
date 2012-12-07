From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Dec 2012 09:11:30 +0100
Subject: [PATCH 1/2] clk: introduce optional disable_unused callback
In-Reply-To: <CAPtuhTgLerjExjuS7Qk4NNDkOvZx8xLQfDuVS6gJLTGbmqGtGQ@mail.gmail.com>
References: <1354654823-1576-1-git-send-email-mturquette@linaro.org>
 <1354654823-1576-2-git-send-email-mturquette@linaro.org>
 <CACRpkdbRK6qpO74pU=fKL8Jz0_ENV_SJjvyFXEYKEpx802rnog@mail.gmail.com>
 <CAPDyKFqnRQFds0=aQ5RLhU5yohfOJrCM6UBOLmKbMaD-71RWSA@mail.gmail.com>
 <CAPtuhTgLerjExjuS7Qk4NNDkOvZx8xLQfDuVS6gJLTGbmqGtGQ@mail.gmail.com>
Message-ID: <CACRpkdaDr3d2P7Oe8qYG4RS7pv2doqynVYn-z4pN4Y74yW=33A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 6, 2012 at 11:05 PM, Mike Turquette <mturquette@linaro.org> wrote:
> On Thu, Dec 6, 2012 at 1:58 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>> According to commit msg, it seems like the .disable_unused function
>> will be optional and must only be implemented for those clks that has
>> has special issues to consider.
>>
>
> That is correct.  I don't want people to read the above code while
> porting their platform and perceive that .disable_unused is mandatory
> in any way.  Using the same function in both pointers defeats the
> purpose of the new optional callback.

Aha I get it...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
