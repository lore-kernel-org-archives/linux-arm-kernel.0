From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 12 Apr 2012 09:58:10 +0530
Subject: [PATCH 01/13] clk: core: correct clk_set_rate kerneldoc
In-Reply-To: <1334192572-12499-2-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-2-git-send-email-mturquette@linaro.org>
Message-ID: <4F8659DA.4030305@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2012 6:32 AM, Mike Turquette wrote:
> - * If clk has the CLK_SET_RATE_GATE flag set and it is enabled this call
> - * will fail; only when the clk is disabled will it be able to change
> - * its rate.

Why is CLK_SET_RATE_GATE removed? I already sent a patch to fix clk_set_rate()
for this. And i think it should be required.

-- 
viresh
