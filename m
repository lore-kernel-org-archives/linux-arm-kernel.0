From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Nov 2015 09:28:23 +0100
Subject: [PATCH 11/11] tty: amba-pl011: add support for ZTE UART
 (EXPERIMENTAL)
In-Reply-To: <E1Ztcw9-0007Cz-TX@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcw9-0007Cz-TX@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbMUTUTJvCZXusMHDO4oqhXwo1DT8=h67ej9GSoDR5jvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2015 at 3:51 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add (incomplete) support for the ZTE UART to the AMBA PL011 driver.
> This is similar to the ARM and ST variants, except it has a different
> register address layout, and requires 32-bit accesses to the registers.
> Use the newly introduced register tables and access size support to
> cope with these differences.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I applied the whole series, 1-11 and tested on Ux500 (ST Micro variant)
and on the ARM RealView PB11MPCore.

It works like a charm. I also like the looks of this transformation.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
