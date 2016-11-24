From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Nov 2016 15:13:04 +0100
Subject: [PATCH RESEND 1/2] gpio: axp209: use correct register for GPIO
 input status
In-Reply-To: <20161123141151.25315-2-quentin.schulz@free-electrons.com>
References: <20161123141151.25315-1-quentin.schulz@free-electrons.com>
 <20161123141151.25315-2-quentin.schulz@free-electrons.com>
Message-ID: <CACRpkdY_FOK1KDRq+pvhZ0aZW2g4D8BgvxpLtf38ujXPy3QkGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 3:11 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> The GPIO input status was read from control register
> (AXP20X_GPIO[210]_CTRL) instead of status register (AXP20X_GPIO20_SS).
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
