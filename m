From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 13:44:43 -0700
Subject: [PATCH 6/6] clk: stm32mp1: remove ck_apb_dbg clock
In-Reply-To: <1522996773-24129-7-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
 <1522996773-24129-7-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152304748362.94378.13779011954440917162@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting gabriel.fernandez at st.com (2018-04-05 23:39:33)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> It's recommended to use only clk_sys_dbg clock instead to activate
> debug IP.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next
