From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 20:36:57 +0200
Subject: [PATCH/RESEND 1/2] gpio: rcar: Remove #gpio-range-cells DT
 property usage
In-Reply-To: <1378907462-19247-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1378907462-19247-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1378907462-19247-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CACRpkdZ4EaUVgYoMP6VMefZgE1T--5hh18RzupQLnbd0KpveAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 3:51 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Commit a1bc260bb5f5d95da854be7898202d788e94448d ("gpio: clean up
> gpio-ranges documentation") deprecated the #gpio-range-cells property.
> Replace its usage with a hardcoded value in the gpio-rcar driver.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Simon please take the whole set into the SH tree.

Yours,
Linus Walleij
