From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 13:44:41 -0700
Subject: [PATCH 5/6] clk: stm32mp1: set stgen_k clock as critical
In-Reply-To: <1522996773-24129-6-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
 <1522996773-24129-6-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152304748126.94378.3341413958898112749@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting gabriel.fernandez at st.com (2018-04-05 23:39:32)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> stgen_k should be declared as critical to avoid blocking console
> when ck_hsi is not used.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next
