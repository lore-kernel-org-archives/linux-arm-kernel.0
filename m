From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 13:45:38 -0700
Subject: [PATCH RESEND 1/2] clk: stm32: END_PRIMARY_CLK should be declare
 after CLK_SYSCLK
In-Reply-To: <1520578651-28849-2-git-send-email-gabriel.fernandez@st.com>
References: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
 <1520578651-28849-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <152149233843.242365.271342087460300826@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting gabriel.fernandez at st.com (2018-03-08 22:57:30)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Update of END_PRIMARY_CLK was missed, it should be after CLK_SYSCLK
> hsi and sysclk are overwritten by gpioa and gpiob.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Tested-by: Philippe Cornu <philippe.cornu@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
