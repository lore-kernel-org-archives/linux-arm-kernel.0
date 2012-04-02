From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 2 Apr 2012 09:02:10 +0530
Subject: [PATCH] pinctrl: Replace list_*() with get_*_count()
In-Reply-To: <4F75DDFE.3030408@wwwdotorg.org>
References: <10b8e68e37a8992646e9b84521ec48953612d83c.1333086742.git.viresh.kumar@st.com>
 <4F75DDFE.3030408@wwwdotorg.org>
Message-ID: <4F791DBA.3020408@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/30/2012 9:53 PM, Stephen Warren wrote:
> One small issue to fix though: In pinctrl-tegra.c, you've removed all
> the range-checkes from the ops functions, except you forgot to update
> tegra_pinctrl_disable().

Aahh!! I would send a fixup/incremental patch for that.

-- 
viresh
