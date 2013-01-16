From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 15:19:44 -0700
Subject: [PATCH 7/7] ARM i.MX5: Add system reset controller (SRC) to i.MX51
 and i.MX53 device tree
In-Reply-To: <1358352787-15441-8-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-8-git-send-email-p.zabel@pengutronix.de>
Message-ID: <50F72780.8040208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 09:13 AM, Philipp Zabel wrote:
> Also, link SRC to IPU via phandle.

Aside from the comments I already made, the series,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

although I'm not 100% sure if the ordering of patches maintains a
working i.MX build all the time? Does "git bisect" work across the series?

Who would merge these patches?
