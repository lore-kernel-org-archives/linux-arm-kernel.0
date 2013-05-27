From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 13:39:07 +0200
Subject: [PATCH] ARM: ux500: regulators: Remove misleading comment
In-Reply-To: <1369227995-17142-1-git-send-email-lee.jones@linaro.org>
References: <1369227995-17142-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYAd=X7rCj+Xs=cQ5CZf3-mpLpiGKjmfVZ+pC_QSq-+Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch removes a comment which explains that the ab8505 platform
> uses the same initialisation settings as the ab8500. Well when this
> changed and the ab8505 started using its own set of initialisation
> values, someone forgot to remove it.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied for ux500-core, thanks!

Yours,
Linus Walleij
