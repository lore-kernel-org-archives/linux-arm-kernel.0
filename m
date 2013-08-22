From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 Aug 2013 09:19:15 -0700
Subject: [GIT PULL] Nomadik I2C for v3.12
In-Reply-To: <CACRpkdYxUJy3pt8uD6as+7Uz2c_giizhib2s7Gv0GHxNmy-+eQ@mail.gmail.com>
 (Linus Walleij's message of "Mon, 19 Aug 2013 11:52:19 +0200")
References: <CACRpkdYxUJy3pt8uD6as+7Uz2c_giizhib2s7Gv0GHxNmy-+eQ@mail.gmail.com>
Message-ID: <87y57tsnp8.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Hi ARM SoC folks,
>
> here is a single patch for the Nomadik, switching it to use the
> actual I2C silicon instead of bit-banging.
>
> Please pull it into the ARM SoC tree!
>
> Yours,
> Linus Walleij
>
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/nomadik-i2c-for-arm-soc
>
> for you to fetch changes up to 66e0c12f9e17a1c97fc358f9e1f5e1dc615e279a:
>
>   ARM: nomadik: switch to use the Nomadik I2C driver (2013-08-07 00:59:06 +0200)
>
> ----------------------------------------------------------------
> Enables the standard Nomadik I2C driver for use
> on the original Nomadik instead of using a bit-banged
> driver.

Pulled into next/dt.

Kevin
