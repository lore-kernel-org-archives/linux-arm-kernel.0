From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Feb 2014 10:59:40 +0100
Subject: [PATCH 2/2] pinctrl: nomadik: Convert to modern pm_ops
In-Reply-To: <1392209979-31636-2-git-send-email-ulf.hansson@linaro.org>
References: <1392209979-31636-1-git-send-email-ulf.hansson@linaro.org>
 <1392209979-31636-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdbY82BLa6CdfLS5cc5wAf96oiBnK=vjOCy=_6mR3zaqpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 1:59 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Use the SIMPLE_DEV_PM_OPS macro and convert to the modern pm ops.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Yep this is what we want to do!

Patch applied.

Yours,
Linus Walleij
