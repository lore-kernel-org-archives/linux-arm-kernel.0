From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Sep 2014 10:45:16 +0200
Subject: [PATCH 11/11 v5] ARM: removing support for etb/etm in
 "arch/arm/kernel/"
In-Reply-To: <1409159852-7249-12-git-send-email-mathieu.poirier@linaro.org>
References: <1409159852-7249-1-git-send-email-mathieu.poirier@linaro.org>
 <1409159852-7249-12-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CACRpkdZerhSgrGimebPY-iY3aV40wRyf-DjsSS+iMOgOj1k_Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 7:17 PM,  <mathieu.poirier@linaro.org> wrote:

> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>
> Removing minimal support for etb/etm to favour an implentation
> that is more flexible, extensible and capable of handling more
> platforms.
>
> Also removing the only client of the old driver.  That code can
> easily be replaced by entries for etb/etm in the device tree.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

The new driver is clearly better.

Yours,
Linus Walleij
