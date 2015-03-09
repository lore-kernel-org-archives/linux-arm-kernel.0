From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:41:21 +0100
Subject: [PATCH v5 6/8] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <54F88EB8.3020208@broadcom.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-7-git-send-email-rjui@broadcom.com>
 <1425543104.24292.185.camel@x220> <1425544581.24292.194.camel@x220>
 <54F88EB8.3020208@broadcom.com>
Message-ID: <CACRpkdbG3t3QEobibbf7wquTtCRm=B0qwivoAp9FTkYpYNL9JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 5, 2015 at 6:13 PM, Ray Jui <rjui@broadcom.com> wrote:

>> (I knew the other three MODULE_* macros are handled in slightly more
>> complicated way, but the effect is basically that they are preprocessed
>> away.)
>>
>> Paul Bolle
>
> Even these module macros will be pre-processed away when the driver is
> statically linked (and yes, I'm not planning to ever make these driver
> built as module), I'm not too sure about the convention here. I thought
> that they are still good to be in the driver for information purpose.
> I'm seeing other pinctrl drivers doing this as well.
>
> Maybe Linus can help to clarify this?

As pointed out in another mail on similar subject, I think these macros
are a kind of obsolete documentation and if they should be dropped we
need to go over an entire subsystem at a time and remove all boolean users
in a big patch.

Yours,
Linus Walleij
