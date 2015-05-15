From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 May 2015 18:13:05 -0700
Subject: [PATCH v3 2/9] Documentation: bindings: move the Berlin clock
 documentation
In-Reply-To: <1428417909-27378-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1428417909-27378-1-git-send-email-antoine.tenart@free-electrons.com>
 <1428417909-27378-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150515011305.GH31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07, Antoine Tenart wrote:
> The Berlin clock documentation was part of the Marvell Berlin SoC
> documentation because the Berlin clock configuration was inside the
> chip controller. With the recent rework of the chip and system
> controller handling (now all sub-devices of the soc and system
> controller nodes are registred with simple-mfd, and each device has its
> own sub-node), the documentation of the Berlin clock driver can be moved
> to the generic clock documentation directory.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
