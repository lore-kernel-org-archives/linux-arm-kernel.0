From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:36:20 +0200
Subject: [PATCH 14/18] dmaengine/amba-pl08x: Choose peripheral bus as
	master bus
In-Reply-To: <c1cb9cd2abc64b4efdc3648896324a1821fdba3e.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<c1cb9cd2abc64b4efdc3648896324a1821fdba3e.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MobiWWL_sC2vGE5bUM-n_uG+awVHAJVyjjxYTBcjXHGUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> When we have DMA transfers between peripheral and memory, then we shouldn't
> reduce width of peripheral at all, as that may be a strict requirement. But we
> can always reduce width of memory access, with some compromise in performance.
> Thus, we must select peripheral as master and not memory.
>
> Also this rearranges code to make it shorter.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Looks correct to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
