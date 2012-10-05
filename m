From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Oct 2012 14:21:15 +0200
Subject: [PATCH V2 0/3] spi: spi-pl022: Fixup use of runtime pm
In-Reply-To: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdbYzr4HH1tFjnZT0A=v_iOGVbkey_vxyAUW+85nw2bEZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2012 at 10:04 AM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Some old runtime pm patches got merged whiched messed up things.
> These are now reverted. Additionaly one patch do a simplification
> of the use of runtime pm functions.
>
> V2:
> Rebased patches and updated commit messages.
>
> Ulf Hansson (3):
>   Revert "spi/pl022: fix spi-pl022 pm enable at probe"
>   Revert "spi/pl022: enable runtime PM"
>   spi: spi-pl022: Minor simplification for runtime pm

I think patch 1/3 and 2/3 needs to go into the -rc fixes.

Who's funneling this now? Grant or Mark?

Yours,
Linus Walleij
