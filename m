From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Dec 2012 22:44:09 +0100
Subject: [PATCH v4 2/7] pl080.h: moved from arm/include/asm/hardware to
 include/linux/amba/
In-Reply-To: <1355146956-6009-3-git-send-email-ciminaghi@gnudd.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <1355146956-6009-3-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CACRpkdbF6S6nOQFwv+tmS4LXhnnwkQxzmGYmH3Xn6TM4E34r8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 2:42 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:

> From: Alessandro Rubini <rubini@gnudd.com>
>
> The header is used by drivers/dma/amba-pl08x.c, which can be compiled
> under x86, where PL080 exists under a PCI-to-AMBA bridge. This patche
> moves it where it can be accessed by other architectures, and fixes
> all users.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Didn't I already ACK this?
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls ask Vinod to merge this.

Yours,
Linus Walleij
