From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:27:31 +0200
Subject: [PATCH 5/9] ARM: ux500: Fix incorrect DEBUG UART virtual addresses
In-Reply-To: <1368019749-19455-6-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY669Af-DK9jPkW==u9PtqnL=pipiN9Rx8hi=PHO5mtyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:

> A recent move to rid header files which were hindering multiplatform
> support forced address allocations out of the headers and into the
> files which were using them. We also lost some useful macros such as
> IO_ADDRESS(), so physical -> virtual addressing has been carried out
> manually in this case. Unfortunately the incorrect value was converted.
> This patch rectifies the error and ensures earlyprintk works again.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks for fixing this!

And sorry for screwing it up :-(

Patch applied!

Yours,
Linus Walleij
