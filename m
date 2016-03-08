From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Mar 2016 15:18:26 +0700
Subject: [PATCH] pinctrl-bcm2835: Fix cut-and-paste error in "pull" parsing
In-Reply-To: <1456795808-1449-1-git-send-email-eric@anholt.net>
References: <1456795808-1449-1-git-send-email-eric@anholt.net>
Message-ID: <CACRpkdZT9BvDc3f4mf22jGb5PQOVVgBU+pSrzhxrqfbczHNG8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2016 at 8:30 AM, Eric Anholt <eric@anholt.net> wrote:

> From: Phil Elwell <phil@raspberrypi.org>
>
> The DT bindings for pinctrl-bcm2835 allow both the function and pull
> to contain either one entry or one per pin. However, an error in the
> DT parsing can cause failures if the number of pulls differs from the
> number of functions.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: stable at vger.kernel.org
> ---
>
> Yes, the s-o-b differs from the author of the commit, but this falls
> under part b) of the process.
>
> Phil, any chance you could start putting Signed-off-by lines on your
> kernel commits?

Patch applied with the extra SoB and Stephen's review tag.

Yours,
Linus Walleij
