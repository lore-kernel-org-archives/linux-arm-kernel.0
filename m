From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 13:44:36 -0700
Subject: [PATCH 3/6] clk: stm32mp1: fix SAI3 & SAI4 clocks
In-Reply-To: <1522996773-24129-4-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
 <1522996773-24129-4-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152304747637.94378.7897600827238802645@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting gabriel.fernandez at st.com (2018-04-05 23:39:30)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> fix bad copy / paste.
> SAI3 & SAI4 used gate of SAI2 instead SAI3 & SAI4
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next
