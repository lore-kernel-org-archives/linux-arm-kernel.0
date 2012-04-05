From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 16:10:40 +0530
Subject: Query: clk: Defining new struct clk_foo types
In-Reply-To: <20120405103039.GC3852@pengutronix.de>
References: <4F7D443E.3010800@st.com> <20120405095835.GB20478@pengutronix.de>
 <4F7D705D.7050004@st.com> <20120405103039.GC3852@pengutronix.de>
Message-ID: <4F7D76A8.3080904@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2012 4:00 PM, Sascha Hauer wrote:
> Besides, I don't  recommend using the DEFINE_CLK_* macros. You should
> really consider using clk_register_* instead.

Can you point me to some users of this clock framework, with such
runtime stuff? That would be really helpful.

-- 
viresh
