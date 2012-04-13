From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 13 Apr 2012 14:40:12 +0530
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120413085901.GG3168@opensource.wolfsonmicro.com>
References: <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411092034.GV24211@n2100.arm.linux.org.uk>
 <20120411094231.GO3852@pengutronix.de>
 <20120411094704.GY24211@n2100.arm.linux.org.uk> <4F879E9D.2090502@st.com>
 <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com>
Message-ID: <4F87ED74.8020308@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 2:29 PM, Mark Brown wrote:
> Or we need to dump the arguments into a struct.

Then we would end up creating too many structures in our mach/clock.c
files. That will look bad. May perform better. :)

-- 
viresh
