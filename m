From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Oct 2012 11:07:48 +0200
Subject: [PATCH 02/10] ARM: ux500: Strip out duplicate touch screen
 platform information
In-Reply-To: <1349165603-24401-3-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
 <1349165603-24401-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZDO7NRGr7ON6_EpsQzqcBbfO8Dx4M3yWphBgn6y3bnrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:

> We're currently carrying two 'struct bu21013_platform_device's which
> are identical for no apparent reason. Here we remove the extra burden
> and apply the same information to the two different instances of the
> bu21012_tp driver registration.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Makes perfect sense.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
