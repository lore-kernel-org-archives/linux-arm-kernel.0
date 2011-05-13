From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 May 2011 16:22:13 +0200
Subject: [PATCH] spi/amba-pl022: work in polling or interrupt mode if
	pl022_dma_probe fails
In-Reply-To: <a105605733caadfea25034ce0b8af73eb907fd33.1305287569.git.viresh.kumar@st.com>
References: <a105605733caadfea25034ce0b8af73eb907fd33.1305287569.git.viresh.kumar@st.com>
Message-ID: <BANLkTik0RJTA8EVMEOnBS=M4t+KHH+MJRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/13 Viresh Kumar <viresh.kumar@st.com>:

> If pl022_dma_probe fails, we can try to transfer data in polling or interrupt
> mode. Also, set platform_info->enable_dma to 0, so that no other code tries to
> use dma.

Sure why not!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
