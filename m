From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 May 2013 15:20:19 +0200
Subject: [PATCH] regulator: ab8500: Remove external regulator init()
 clauses
In-Reply-To: <1369228025-17192-1-git-send-email-lee.jones@linaro.org>
References: <1369228025-17192-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda0Oupr56a+Tj7jKCh2vCaD_R0_KVFBe8ZuYQYgVtG2CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 3:07 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The driver no longer needs to worry about which platform can and can't
> use external regulators successfully. Instead platform code will hold
> back external regulator initialisation data in the use-cases where the
> driver isn't applicable.
>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
