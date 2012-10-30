From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Oct 2012 22:37:46 +0100
Subject: [PATCH 1/2] input: qt1070: add pinctrl consumer
In-Reply-To: <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121023131627.GE18964@game.jcrosoft.org>
 <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdaTciRNsG8viz19FQajFExX+ApPNcnnVBneecSe_w-EsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 3:29 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> If no pinctrl available just report a warning as some architecture may not
> need to do anything.
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-input at vger.kernel.org

We're having a discussion on the level of where to impose pinctrl.

Jean-Christophe, could you please check the thread
"Input: omap4-keypad: Add pinctrl support"
and tell us what you think is the best approach?

Yours,
Linus Walleij
