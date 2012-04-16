From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 16:28:19 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416105648.GA414@glitch>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk> <20120416105648.GA414@glitch>
Message-ID: <4F8BFB4B.4020900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2012 4:26 PM, Domenico Andreoli wrote:
>> > If you're going to abuse the interface by passing a NULL clk_lookup or
>> > num=0 then you deserve to get a big fat oops to tell you that you messed
>> > up.  Same for NULL dev_id and con_id above.
> I hope for a BUG_ON then.

Would be better if we place that in clkdev_alloc(), instead of this one.

-- 
viresh
