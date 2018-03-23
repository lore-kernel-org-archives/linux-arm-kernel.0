From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 23 Mar 2018 09:03:37 -0500
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <1521804875.23017.95.camel@linux.intel.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
 <b5dac2f7-eabb-6e09-2146-775b09d4eca8@codeaurora.org>
 <59df3700-c0bd-6ee8-eeab-6a49cb92d1db@codeaurora.org>
 <1521804875.23017.95.camel@linux.intel.com>
Message-ID: <819014ea-d375-5830-e32f-eeba73e6fa08@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/18 6:34 AM, Andy Shevchenko wrote:
> No, it seems you missed %p vs. %px discussion.
> 
> The pointers printed by %p nowadays are hashed values, not the original
> ones.

I totally forgot about that, thanks.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
