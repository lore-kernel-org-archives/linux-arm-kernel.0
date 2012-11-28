From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Nov 2012 17:04:44 +0100
Subject: [PATCH 3/8 v3] pl080.h: moved from arm/include/asm/hardware to
 include/linux/amba/
In-Reply-To: <1353716576-19783-1-git-send-email-ciminaghi@gnudd.com>
References: <CAOh2x=keCbnPQzxB+AT5hEt_ukQ6GhPLuxkaQJCML27H9LbWwg@mail.gmail.com>
 <1353716576-19783-1-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CACRpkdYFfPVogqW3UTP4CU-ZfBE7_awGOYxcTZiTRrq-49FdwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 1:22 AM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:

> From: Alessandro Rubini <rubini@gnudd.com>
>
> The header is used by drivers/dma/amba-pl08x.c, which can be compiled
> under x86, where PL080 exists under a PCI-to-AMBA bridge. This patche
> moves it where it can be accessed by other architectures, and fixes
> all users.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

OK!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
