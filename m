From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Nov 2011 16:17:17 +0100
Subject: [PATCH] mmc: mmci: Fixup handling of MCI_STARTBITERR
In-Reply-To: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
References: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdazenok0RHQL0kXLKk2i3bcrWZ9aWDmoCGfjF6JpEoySA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 4:33 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> The interrupt was previously enabled and then correctly cleared.
> Now we also handle it correctly.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This should also go to -stable I think?

Linus Walleij
