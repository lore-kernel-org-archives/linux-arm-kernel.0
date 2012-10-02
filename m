From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Oct 2012 11:18:32 +0200
Subject: [PATCH 04/10] Input: bu21013_ts - Move GPIO init and exit
 functions into the driver
In-Reply-To: <1349165603-24401-5-git-send-email-lee.jones@linaro.org>
References: <1349165603-24401-1-git-send-email-lee.jones@linaro.org>
 <1349165603-24401-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYE1GgLPMjQ-Oz_ap022OykhfK8D7BoN6oTXGYwttxN9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 10:13 AM, Lee Jones <lee.jones@linaro.org> wrote:

> These GPIO init and exit functions have no place in platform data.
> Instead they should be part of the driver. This patch moves them to
> their rightful place, which subsequently elevates platform data of
> yet more cruft.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
