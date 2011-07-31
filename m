From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:44:26 +0200
Subject: [PATCH 17/18] dmaengine/amba-pl08x: Check txd->llis_va before
	freeing dma_pool
In-Reply-To: <1ce7eda8117f76d1e9d35bcf59d188351d1b9465.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<1ce7eda8117f76d1e9d35bcf59d188351d1b9465.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MqxONZr2aKwq0AZbMqsKwiviqUkFF7=mburoXnKQticeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> In pl08x_free_txd(), check if pool is allocated successfully before freeing it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Looks like a good idea.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
