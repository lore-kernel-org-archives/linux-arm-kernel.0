From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Feb 2013 19:29:26 +0100
Subject: [PATCH] dma: Remove erroneous __exit and __exit_p() references
In-Reply-To: <1361318824-22287-1-git-send-email-maxin.john@gmail.com>
References: <1361318824-22287-1-git-send-email-maxin.john@gmail.com>
Message-ID: <CACRpkdZamOCWHWMcFYRqQDKJARZOCEP_eSNPNaxSgHfAn2wmEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 1:07 AM,  <maxin.john@gmail.com> wrote:

> From: "Maxin B. John" <maxin.john@enea.com>
>
> Removing the annotation with __exit and referencing with __exit_p()
> present in dma driver module remove hooks.
>
> Part of the __devexit and __devexit_p() purge.
>
> Signed-off-by: Maxin B. John <maxin.john@enea.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
