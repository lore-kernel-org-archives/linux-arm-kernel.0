From: davem@davemloft.net (David Miller)
Date: Wed, 09 May 2012 21:22:15 -0400 (EDT)
Subject: [PATCH V3 Resend 08/12] net/c_can: Remove conditional
 compilation of clk code
In-Reply-To: <5bde77a369c9bf2eb2efbd9f8d139443336ff849.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
 <5bde77a369c9bf2eb2efbd9f8d139443336ff849.1336448639.git.viresh.kumar@st.com>
Message-ID: <20120509.212215.1769935497710663262.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@st.com>
Date: Tue, 8 May 2012 09:22:35 +0530

> With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
> there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
> macros.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: David S. Miller <davem@davemloft.net>
