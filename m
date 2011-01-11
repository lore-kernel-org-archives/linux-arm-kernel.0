From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 11 Jan 2011 11:09:18 +0530
Subject: [PATCH V3 42/63] ST SPEAr: replace readl, writel with	__raw_readl,
	__raw_writel in uncompress.h
In-Reply-To: <4D26DF03.6050805@windriver.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<73a77c388f8d151ce5bc70000832fbb518babe3b.1292833229.git.viresh.kumar@st.com>
	<4D2679D1.3080005@windriver.com>
	<20110107091720.GM31708@n2100.arm.linux.org.uk>
	<4D26DF03.6050805@windriver.com>
Message-ID: <4D2BED06.7060506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2011 03:08 PM, stanley.miao wrote:
> With this in mind, I think readl_relaxed() should be better here.

Stanley,

Actually we never thought of endianness while coding it, and
followed the most generic approach taken by other archs.

Yes, i do accept *_relaxed() should be used instead.

I will do that in V4.

-- 
viresh
