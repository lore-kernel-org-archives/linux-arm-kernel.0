From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 20 Jul 2017 00:02:46 +0300
Subject: [PATCH v7 2/3] clk: gate: expose clk_gate_ops::is_enabled
In-Reply-To: <1500474344-9832-3-git-send-email-gabriel.fernandez@st.com>
References: <1500474344-9832-1-git-send-email-gabriel.fernandez@st.com>
 <1500474344-9832-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <eba13ecf-1034-dbfa-0398-4a907cf13b29@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2017 05:25 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch exposes clk_gate_ops::is_enabled as functions
> that can be directly called and assigned in places like this so
> we don't need wrapper functions that do nothing besides forward
> the call.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Sugested by Stephen Boyd <sboyd@codeaurora.org>

Fixing the spelling etc. I believe the last tag line should be

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>

--
With best wishes,
Vladimir
