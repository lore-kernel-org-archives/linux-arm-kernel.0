From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:45:35 +0200
Subject: [PATCH 18/18] dmaengine/amba-pl08x: Call pl08x_free_txd() instead
	of calling kfree() directly
In-Reply-To: <90793b4b9824f8152aa4cea07fd91a8ecd3481e8.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<90793b4b9824f8152aa4cea07fd91a8ecd3481e8.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MqGpbVSkuuPCZoqXw+8-RVDFFf7ju4pGaGZ9vLOXRLVhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> pl08x_prep_channel_resources() is calling kfree() directly for txd(). To
> maintain consistency in code call pl08x_free_txd() instead.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Good idea,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
