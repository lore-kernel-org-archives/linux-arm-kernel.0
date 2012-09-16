From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 00:13:41 +0200
Subject: [PATCH 1/8] DMA: PL330: use prefix in reg names to build under x86
In-Reply-To: <1347639843-32119-2-git-send-email-dciminaghi@mail.gnudd.com>
References: <1347639843-32119-1-git-send-email-dciminaghi@mail.gnudd.com>
 <1347639843-32119-2-git-send-email-dciminaghi@mail.gnudd.com>
Message-ID: <CACRpkdYW2jYp4PSRiBQbPSt=U99JQPyb5Y9x57ORM9pgVJYWMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 6:23 PM, Davide Ciminaghi
<dciminaghi@mail.gnudd.com> wrote:

> From: Alessandro Rubini <rubini@gnudd.com>
>
> This driver would not compile if ARM_AMBA is selected under x86,
> because "CS" and "DS" are already defined there.  But AMBA
> is used in the x86 world by a PCI-to-AMBA bridge, to be submitted.
>
> The patch adds the "PL330_" prefix to all register and bit fields,
> so it can be built by randomconfig after ARM_AMBA appears within x86.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Looks sound.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
