From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 16:07:17 -0700
Subject: [PATCH v3 0/3] clk: meson: Add clock controller
In-Reply-To: <1433157235-17275-1-git-send-email-carlo@caione.org>
References: <1433157235-17275-1-git-send-email-carlo@caione.org>
Message-ID: <20150604230717.GE8099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patchset introduces preliminary support for the clock controller
> found on Amlogic MesonX SoCs and enables it for the Meson8b.
> 
> DTS patches with support for Meson8b SoCs will follow.
> 

Did you want to send the dts changes through arm-soc? Do they
depend on the header file that is included here? clk-next is not
stable and shouldn't be pulled into other developer's trees, so
if we need some stable commit to give off to arm-soc for v4.2
we need to know soon. Or we can split the header file off into a
different patch and send it through both arm-soc and clk tree.

Otherwise the patches look good. I fixed up the __init markings
on some functions which were in the wrong place.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
