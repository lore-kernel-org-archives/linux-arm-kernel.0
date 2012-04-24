From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 11:39:49 +0530
Subject: [PATCH 08/13] net/stmmac: Remove conditional compilation of clk
 code
In-Reply-To: <4F964099.7030401@st.com>
References: <cover.1335008617.git.viresh.kumar@st.com>
 <03d5825c44251e6cbbdb3c3d8e67208f0fd4619d.1335008617.git.viresh.kumar@st.com>
 <4F964099.7030401@st.com>
Message-ID: <4F9643AD.6000906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 11:26 AM, Giuseppe CAVALLARO wrote:
> I like this patch also because reduces ifdef in the code :-)

thanks.

> Anyway this patch doesn't apply fine either in net-next and in net.git.
> Also I wonder if you had already tested the driver build on arch w/o
> HAVE_CLK ... just to avoid kernel build failures on other platforms.
> 
> Let me know if I can help you on that.

I already sent V2, before i saw this mail. V2 will get rebased cleanly.
Yes i have tried that.

BTW, this series must go through Andrew, instead of your tree as it
has dependency patches. Just for info.

-- 
viresh
