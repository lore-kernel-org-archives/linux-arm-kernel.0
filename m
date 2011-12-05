From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 05 Dec 2011 08:37:20 +0530
Subject: [PATCH] dmaengine/amba-pl08x: Config ccfg and increment
 phychan_hold if phychan is true
In-Reply-To: <fc4d77e6355cc462cfc2e700415cd56b9db816cb.1322551469.git.viresh.kumar@st.com>
References: <fc4d77e6355cc462cfc2e700415cd56b9db816cb.1322551469.git.viresh.kumar@st.com>
Message-ID: <1323054440.30390.53.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-29 at 12:56 +0530, Viresh Kumar wrote:
> Currently, if plchan->phychan is true, we return immediately from
> prep_phy_chan(). We must configure txd->ccfg and increment phychan_hold before
> returning. Otherwise, request line number wouldn't be configured in this txd.
> 
> Reported-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Applied, Thanks

-- 
~Vinod
