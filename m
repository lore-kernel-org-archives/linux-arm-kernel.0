From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Nov 2013 10:42:13 +0100
Subject: [PATCH] gpio: pl061: don't depend on CONFIG_ARM
In-Reply-To: <1383708422-20374-1-git-send-email-robherring2@gmail.com>
References: <1383708422-20374-1-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdZbVAyd9FRr39xLVVp4bmKmkGL=AUUB=sF+wSksdLcnGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 4:27 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> The pl061 driver has no real dependency on ARM, so remove the kconfig
> dependency.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio at vger.kernel.org

Patch applied. Let's throw it at the autobuilder and see what
happens :-)

Yours,
Linus Walleij
