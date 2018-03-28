From: keescook@chromium.org (Kees Cook)
Date: Wed, 28 Mar 2018 04:55:29 -0700
Subject: [PATCH v2 21/21] arm64: move GCC version check for
 ARCH_SUPPORTS_INT128 to Kconfig
In-Reply-To: <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAGXu5jJUp6GaDtEKwg7_nOoyDEumZx0MTeW4cr_NFSbNxxa06Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This becomes much neater in Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Is there a reason this doesn't have a cc-option test, or was this a
silent addition to the compiler? (And as such, should there be a
comment for this in the Kconfig?)

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
