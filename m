From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 09:04:43 +0200
Subject: [PATCH 2/9] pinctrl: pinctrl-nomadik: Append sleepmode property
 with vendor specific prefixes
In-Reply-To: <1341493572-29735-3-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZDQB+ycvXxmVB0CkVPo6PAjiXBQFpTYVGoekz+eyOHGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Any non-standard property should contain the vendor's identifier which
> should be perpended onto the property name followed by a comma. This
> aids in name-space collision prevention. This patch ensures the
> sleepmode property adheres to the rules.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

OK, Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
