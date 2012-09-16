From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 00:11:59 +0200
Subject: [PATCH 3/8] pl080.h: moved from arm/include/asm/hardware to
 include/linux/amba/
In-Reply-To: <1347639843-32119-4-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
 <1347639843-32119-4-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <CACRpkdbaJ6p7wbW5LukET9kE2=jY5w5s74-duPJR7H-XsPPhZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 6:23 PM, Davide Ciminaghi
<dciminaghi@mail.gnudd.com> wrote:

> From: Alessandro Rubini <rubini@gnudd.com>
>
> The header is used by drivers/dma/amba-pl08x.c, which can be compiled
> under x86, where PL080 exists under a PCI-to-AMBA bridge. This patche
> moves it where it can be accessed by other architectures, and fixes
> all users.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

It's not really platform data or anything, but as long as the
old Samsung drivers are using it we cannot cut it from the
global scope, and I cannot think of anything better to do
so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
