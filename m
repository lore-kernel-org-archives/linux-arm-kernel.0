From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 19:48:24 +0200
Subject: [PATCH 6/6] ARM: ux500: Convert DT_MACHINE_START to use SMP
 operations
In-Reply-To: <1351089926-32161-7-git-send-email-lee.jones@linaro.org>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
 <1351089926-32161-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdY88K_qik0=EwJ+mNW80D_D0Hs6t0Y_ydY4x-J_c-i9UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 4:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The Device Tree machine description for the ux5x0 was moved
> recently and as a consequence missed the addition of SMP
> operations. Without this patch SMP doesn't work and only one
> CPU is present after booting.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
