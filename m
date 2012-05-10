From: davem@davemloft.net (David Miller)
Date: Wed, 09 May 2012 21:22:43 -0400 (EDT)
Subject: [PATCH V3 Resend 09/12] net/stmmac: Remove conditional
 compilation of clk code
In-Reply-To: <8e66b900fe5ee10c8db93d2f12c912e3dfb0708f.1336448639.git.viresh.kumar@st.com>
References: <cover.1336448639.git.viresh.kumar@st.com>
 <8e66b900fe5ee10c8db93d2f12c912e3dfb0708f.1336448639.git.viresh.kumar@st.com>
Message-ID: <20120509.212243.1590217502497756920.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@st.com>
Date: Tue, 8 May 2012 09:22:36 +0530

> With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
> there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
> macros.
> 
> This also fixes error paths of probe(), as a goto is required in this patch.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: David S. Miller <davem@davemloft.net>
