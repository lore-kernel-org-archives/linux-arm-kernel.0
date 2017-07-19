From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 20 Jul 2017 00:00:23 +0300
Subject: [PATCH v7 1/3] clk: nxp: clk-lpc32xx: rename clk_gate_is_enabled()
In-Reply-To: <1500474344-9832-2-git-send-email-gabriel.fernandez@st.com>
References: <1500474344-9832-1-git-send-email-gabriel.fernandez@st.com>
 <1500474344-9832-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <6626e519-0b69-367c-1966-6dee894febfc@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gabriel,

On 07/19/2017 05:25 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> We need to export clk_gate_is_enabled() from clk framework, then
> to avoid compilation issue we have to rename clk_gate_is_enabled()
> in NXP LPC32xx clock driver.
> We changed all gate op with 'lpc32xx_' prefix:
> lpc32xx_clk_gate_enable(),
> lpc32xx_clk_gate_disable(),
> lpc32xx_clk_gate_is_enabled().
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
