From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Aug 2012 10:52:49 +0200
Subject: [PATCH 02/14] at91: regroup gpio and pinctrl under a simple-bus
In-Reply-To: <1344603731-32667-2-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdaP1qu5ZAn0-17U-Y_2_d-KoSLszm79HQS8RjBKW0+iSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 3:01 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> Fix also the reg size as we have 512 bytes bank not 256 bytes per gpio/mux
> controller
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Not that I understand device tree, so you rpobably want
Nicolas to review this one rather than me, but FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
