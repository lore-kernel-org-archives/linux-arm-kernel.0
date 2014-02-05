From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Feb 2014 13:49:49 +0100
Subject: [PATCH 05/17] mmc: mmci: Put the device into low power state at
 system suspend
In-Reply-To: <8738jyu1h9.fsf@paris.lan>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-6-git-send-email-ulf.hansson@linaro.org>
 <8738jyu1h9.fsf@paris.lan>
Message-ID: <CACRpkdZt5+t7b0_a__2kJP4V9PS2cyXmguWrST+fzbKCnosi7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 4, 2014 at 8:22 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> Due to the available runtime PM callbacks, we are now able to put our
>> device into low power state at system suspend.
(...)
> I'm trying to thing of a good reason to not make PM_SLEEP depend on
> PM_RUNTIME for platforms like this.

Isn't the typical Android platform using PM_SLEEP without using
PM_RUNTIME?

Yours,
Linus Walleij
