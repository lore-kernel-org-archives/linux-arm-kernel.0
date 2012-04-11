From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2012 00:47:20 +0200
Subject: [PATCH 1/1] ARM: Rename CONFIG_ARM_AMBA to CONFIG_ARM_PRIMECELL
In-Reply-To: <9c8b8d1212528994ea09c9cc57428ce3d1f45da9.1333663714.git.rubini@gnudd.com>
References: <cover.1333663714.git.rubini@gnudd.com>
 <9c8b8d1212528994ea09c9cc57428ce3d1f45da9.1333663714.git.rubini@gnudd.com>
Message-ID: <CACRpkdbDZCwQLdrPtm-VD6-iCD0hgsNos=KB7P6PL6-p=upjZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2012 at 12:22 AM, Alessandro Rubini <rubini@gnudd.com> wrote:

> The AMBA bus (Advanced Microcontroller Bus Architecture) is just an
> interconnection bus that needs no software support. ?Software support
> offered in Linux is some sort of enumeration that only applies to
> "PrimeCell" logic blocks (devices). ?This renames the config option
> to match reality.
>
> Change suggested by Russell King.
>
> Note: CONFIG_ARM_AMBA is retained and is enabled when
> CONFIG_ARM_PRIMECELL is selected. ?So any #ifdef in out-of-tree
> drivers will still work until the symbol will be removed in due time.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Yeah this thing can be a bit confusing...

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
