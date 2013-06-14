From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Jun 2013 20:21:10 +0800
Subject: [PATCH 1/7] ARM: mxc: fix gpio-ranges for VF610
In-Reply-To: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
References: <1371157199-7272-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130614122108.GA4489@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 02:59:53PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The gpio-ranges properties in vf610.dtsi were written according to an
> older version of the GPIO bindings. Unfortunately, these were changed
> incompatibly in commit 86853c8 "gpio: add gpio offset in gpio range
> cells property". This patch adds the missing required extra cell in each
> gpio-ranges property.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.

Shawn
