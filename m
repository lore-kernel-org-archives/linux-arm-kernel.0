From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 15:54:55 +0200
Subject: [PATCH] ARM: ux500: select REGULATOR
In-Reply-To: <1368621401-18569-1-git-send-email-emilio@elopez.com.ar>
References: <1368621401-18569-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <CACRpkdaDLJk5UE_10FQuFNishY4+bnKShJyeC0JOF33hUq2nqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 2:36 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:

> MACH_MOP500 selects REGULATOR_FIXED_VOLTAGE but not REGULATOR. This
> patch makes it select the latter too.
>
> Seen as:
>     warning: (MACH_DOVE_DT && ARCH_KIRKWOOD_DT && MACH_AMS_DELTA &&
>     MACH_MOP500 && TPS6105X) selects REGULATOR_FIXED_VOLTAGE which has
>     unmet direct dependencies (REGULATOR)
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Applied for ux500 fixes.

Thanks!
Linus Walleij
