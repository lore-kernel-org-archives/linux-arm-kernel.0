From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Sep 2012 22:00:43 +0200
Subject: [PATCH] ARM: ux500: Move regulator-name properties out to board
 DTS files
In-Reply-To: <1348573074-11481-1-git-send-email-lee.jones@linaro.org>
References: <1348573074-11481-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZrAMkzgauHLgas7SYxQb_ycgsOvKrMnAz5Z1yzX1-BjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 1:37 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Regulator supply names should be allocated by board rather than
> per SoC, as the same SoC could be wired differently on varying
> hardware. Here we push all regulator-name allocation out to the
> dbx5x0 subordinate board files; HREF and Snowball.
>
> Requested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
