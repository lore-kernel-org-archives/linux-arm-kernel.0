From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 28 Sep 2012 13:25:52 +0200
Subject: [PATCH 0/3] Fixup use of runtime pm
In-Reply-To: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CAPDyKFoWJ+a1T8DubqOCwNDzEkr=W-8qdmqpCpXMFA7xfwOCDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the heading, should be spi: spi-pl022"

Kind regards
Ulf Hansson

On 28 September 2012 13:21, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Some old runtime pm patches got merged whiched messed up things.
> These is now reverted. Additionaly one patch do a simplification
> of the use of runtime pm functions.
>
> Ulf Hansson (3):
>   Revert "spi/pl022: fix spi-pl022 pm enable at probe"
>   Revert "spi/pl022: enable runtime PM"
>   spi: spi-pl022: Minor simplification for runtime pm
>
>  drivers/spi/spi-pl022.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> --
> 1.7.10
>
