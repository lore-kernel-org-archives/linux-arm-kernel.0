From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Apr 2017 09:27:54 -0700
Subject: [PATCH v2 7/7] clk: spear: fix ADC clock definition on SPEAr600
In-Reply-To: <1492433205-13376-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1492433205-13376-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1492433205-13376-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170419162754.GE7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17, Thomas Petazzoni wrote:
> There is no SPEAr600 device named "adc". Instead, the description of the
> ADC was recently added to the Device Tree, and the device name is
> "d820b000.adc", so we should associate the ADC gatable clock to this
> device name.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
