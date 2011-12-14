From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Dec 2011 18:31:58 +0100
Subject: [PATCH v4 2/5] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
References: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
 <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
Message-ID: <CACRpkdb-trbiJHZEgGS427XTs8A_VnUFMAbnVvL3fp4qmBVX4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 6:56 PM, Dave Martin <dave.martin@linaro.org> wrote:

> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
>
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines. ?To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For "my" platforms...

Yours,
Linus Walleij
