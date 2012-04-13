From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 13 Apr 2012 14:57:36 +0530
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120413092615.GH24211@n2100.arm.linux.org.uk>
References: <20120411092034.GV24211@n2100.arm.linux.org.uk>
 <20120411094231.GO3852@pengutronix.de>
 <20120411094704.GY24211@n2100.arm.linux.org.uk> <4F879E9D.2090502@st.com>
 <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com> <4F87ED74.8020308@st.com>
 <20120413091712.GE27730@b20223-02.ap.freescale.net>
 <20120413092615.GH24211@n2100.arm.linux.org.uk>
Message-ID: <4F87F188.60603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 2:56 PM, Russell King - ARM Linux wrote:
> What's wrong with the struct clk returned from clk_register() - why
> not do this as a two-step process?

Code duplication on all platforms for creating these lookups.

> Especially as you may want to
> associate a single clock with more than one clk_lookup.

Can still be done, as we are still getting clk pointer back.

-- 
viresh
