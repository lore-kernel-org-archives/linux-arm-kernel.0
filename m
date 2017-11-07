From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Nov 2017 21:13:12 +0100
Subject: [PATCH] ARM: sa1100: simpad: Correct I2C GPIO offsets
In-Reply-To: <eee254f2-6c34-0cc3-85e6-a3b70100021c@axentia.se>
References: <20171107151703.3847-1-linus.walleij@linaro.org>
 <eee254f2-6c34-0cc3-85e6-a3b70100021c@axentia.se>
Message-ID: <CACRpkdae=tTxSB2BX14j=_7y0Bz4B-EOEmwWEZNPaZdMnPtq3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 4:25 PM, Peter Rosin <peda@axentia.se> wrote:

>> arch/arm/mach-sa1100/include/mach/SA-1100.h it is
>> defined as:
>
> I suspect that you had a line here that started with a hashmark
> (#) and that the whole line got eaten by some git tool during
> a rebase or something. Don't ever start lines with # in the git
> commit message. It will simply disappear somewhere at some point.

Darn why didn't I think of that. I even knew it.

OK I resend a v2 with proper changelog.

Thanks,
Linus Walleij
