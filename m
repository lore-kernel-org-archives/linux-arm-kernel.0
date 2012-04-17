From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 09:10:14 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416211232.GL20478@pengutronix.de>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
 <20120416205655.GJ20478@pengutronix.de> <20120416210617.GA22932@glitch>
 <20120416211232.GL20478@pengutronix.de>
Message-ID: <4F8CE61E.9090504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2012 2:42 AM, s.hauer at pengutronix.de wrote:
>>> > > Can we drop the 'single' in the name? Otherwise it's quite a long
>>> > > function name. I think name clk_register_clkdev makes it clear already
>>> > > that we only register a single clkdev.
>> > 
>> > clkdev_register?
> Maybe even this. I just though that it might be too easy to confuse with
> clkdev_add (In fact I think clkdev_register would be a good name for
> what clkdev_add currently does, but it's probably not worth the churn
> changing this).

I will keep clk_register_clkdev() and clk_register_clkdevs().

-- 
viresh
