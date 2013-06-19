From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 21:17:35 +0200
Subject: [PATCH v2 2/2] gpio-rcar: Remove #ifdef CONFIG_OF around
 OF-specific sections
In-Reply-To: <1371551389-5493-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1371551389-5493-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1371551389-5493-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CACRpkda+rw802mrdXYvcQRO0qy8hLmid7pdQwg4z=YvH6EY+Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 12:29 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> All functions and data types used by OF-specific code paths are declared
> in <linux/of.h> regardless of CONFIG_OF. Replace the #ifdef CONFIG_OF
> guard with a if(IS_ENABLED(CONFIG_OF)) and let the compiler optimize
> the unused code away.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
