From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 Aug 2017 18:33:01 -0700
Subject: [PATCH 0/2] Add support for Hi6220 coresight
In-Reply-To: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
References: <1504226835-2115-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20170901013301.GN21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01, Leo Yan wrote:
> This patch series adds support for coresight on Hi6220; the first patch
> is to fix coresight PLL so can avoid system hang after we enable
> coresight, the second patch is to add DT binding according to coresight
> topology.
> 
> The patch has been tested on Hikey; By using OpenCSD snapshot mode, it
> can successfully decode ETF and ETB trace data.
> 

I can take the first one and second one goes through arm-soc?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
