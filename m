From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Mar 2017 13:43:07 -0700
Subject: [PATCH 0/2] STM32F4 clock fixes
In-Reply-To: <1489588071-18164-1-git-send-email-gabriel.fernandez@st.com>
References: <1489588071-18164-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170315204307.GK10239@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch-set contains 2 fixes.
> One concerning exclusion of wrong values for PLLQ (0 & 1)
> And the second is a fix about timeout management of PLL and LSE/LSI clocks.

But neither of the patches have a "Fixes" tag. Can you please
indicate what commits they're fixing?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
