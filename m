From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 14:08:39 -0600
Subject: [PATCH] ARM: tegra: Fix dts files w/ status property: "disable"
 -> "disabled"
In-Reply-To: <1339441785-14641-2-git-send-email-stigge@antcom.de>
References: <1339441785-14641-1-git-send-email-stigge@antcom.de>
 <1339441785-14641-2-git-send-email-stigge@antcom.de>
Message-ID: <4FD65047.1060401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 01:09 PM, Roland Stigge wrote:
> This patches fixes some status = "disable" strings to "disabled", the correct
> way of disabling nodes in the devicetree.
> 
> Just the tegra part here. Everything else goes via other patches and trees.

Thanks. Applied to Tegra's for-next.
