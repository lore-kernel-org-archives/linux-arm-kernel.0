From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 Aug 2017 12:04:03 +0200
Subject: [PATCH 2/4] drm/tve200: Add new driver for TVE200
In-Reply-To: <87zib2dlmc.fsf@eliezer.anholt.net>
References: <20170813151132.24736-1-linus.walleij@linaro.org>
 <20170813151132.24736-3-linus.walleij@linaro.org>
 <87zib2dlmc.fsf@eliezer.anholt.net>
Message-ID: <CACRpkdZ1CNBdLQZAUb=aoeNdq29L15yJkWLZ_G90Uz_CyxJmuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 8:56 PM, Eric Anholt <eric@anholt.net> wrote:

> I also recommend checking out panel-bridge for deleting a bunch of the
> code,

Daniel said the same. I tried to look into this but the drivers currently
using it (like Atmel HLCDC) are so different using custom encoders and
what not that I can't really see clearly how to apply it in this case.

If you patch the PL111 driver to use the bridge helper I promise I will
follow up and patch this driver the same way though!

Yours,
Linus Walleij
