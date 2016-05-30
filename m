From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 30 May 2016 14:49:37 +0200
Subject: [PATCH 1/2] clk: exynos5420: Set ID for aclk333 gate clock
In-Reply-To: <1464111662-15336-2-git-send-email-javier@osg.samsung.com>
References: <1464111662-15336-1-git-send-email-javier@osg.samsung.com>
 <1464111662-15336-2-git-send-email-javier@osg.samsung.com>
Message-ID: <574C36E1.5000709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2016 07:41 PM, Javier Martinez Canillas wrote:
> The aclk333 clock needs to be ungated during the MFC power domain switch,
> so set the clock ID to allow the Exynos power domain logic to lookup this
> clock if is defined in the MFC PD device tree node.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, patch applied.
