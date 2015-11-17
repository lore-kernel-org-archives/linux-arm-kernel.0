From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Nov 2015 14:52:19 +0100
Subject: [PATCH 1/2] ARM: ux500: remove regulator-compatible usage
In-Reply-To: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
References: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CACRpkdYWV4FgU-ghRJyh3EO6Z5jmoMc-Q6if5tLAb83zmvrEQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 3:51 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:

> The regulator-compatible property from the regulator DT binding was
> deprecated and the correct approach is to use the node's name.
>
> This patch has no functional changes since the values of the node's
> name and the regulator-compatible match for all the regulators.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Patch applied on my ux500-devicetree branch, will be in my first pull
request to ARM SoC.

Yours,
Linus Walleij
