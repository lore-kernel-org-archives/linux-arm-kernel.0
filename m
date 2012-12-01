From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Dec 2012 16:11:08 +0100
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <1353683310-23654-3-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-3-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CACRpkdZAW_O0AoZD=uOHu7BmEAAbmbc8kLqWfm7iDQrs0TgRdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 4:08 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:

> From: Alessandro Rubini <rubini@gnudd.com>
>
> Commit dece904d (gpio: pl061: use chained_irq_* functions in irq
> handler) introduced chained_irq_enter/exit, which is only
> available for arch/arm and the driver won't compile elsewhere.
>
> The dependency is thus made explicit, because AMBA is used in the x86
> world by a PCI-to-AMBA bridge, to be submitted.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Patch applied with Viresh's ACK.

Yours,
Linus Walleij
