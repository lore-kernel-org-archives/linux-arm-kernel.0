From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Nov 2015 14:53:45 +0100
Subject: [PATCH 2/2] ARM: u300: remove regulator-compatible usage
In-Reply-To: <1443189092-16430-2-git-send-email-javier@osg.samsung.com>
References: <1443189092-16430-1-git-send-email-javier@osg.samsung.com>
 <1443189092-16430-2-git-send-email-javier@osg.samsung.com>
Message-ID: <CACRpkdZOxDbupcJj3Hj-JQDYH=j0a4NprLyD6+2sE9ZJ9E-Zag@mail.gmail.com>
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

Patch applied to ux500-devicetree.

Yours,
Linus Walleij
