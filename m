From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Sep 2015 09:41:55 -0700
Subject: [PATCH] pinctrl: mediatek: Consistently use the BIT() macro
In-Reply-To: <1440804302-6903-1-git-send-email-javier@osg.samsung.com>
References: <1440804302-6903-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CACRpkdYwDXK521OoPJB-xZE3rARMSa-VKLOESZooSnUEqWubLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 4:25 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:

> The mediatek pinctrl driver uses the BIT() macro instead of open
> coding 1 << n in all but one place. Replace this occurrence with
> the BIT() macro for consistency.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Patch applied with Matthias' Ack.

Yours,
Linus Walleij
