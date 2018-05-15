From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 11:23:04 -0700
Subject: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
In-Reply-To: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
References: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152640858418.34267.5971648282268914967@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting gabriel.fernandez at st.com (2018-04-24 00:58:43)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Don't disable the dbg clock if was set by bootloader.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next
