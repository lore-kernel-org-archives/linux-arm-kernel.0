From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 10:54:12 +0100
Subject: [PATCH 08/11] pinctrl: Add new compatible string to GPIO
 controller driver
In-Reply-To: <1445233398-27129-9-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-9-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdZfzRfTkGAgBJ0MzN7D75kVsro7Ar=GzzG8FGJicpVVxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> This compatible string should be used for all new iproc based future
> SoCs having the same GPIO controller hardware.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Stopped applying patches, this looks OK but you will have
to rebase the series on my "devel" branch, addressing the
review comments.

Yours,
Linus Wallewij
