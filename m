From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Aug 2013 10:03:58 -0600
Subject: [PATCH 2/2] ARM: dt: t114 dalmore: add dt entry for nct1008
In-Reply-To: <1375858358-15070-3-git-send-email-wni@nvidia.com>
References: <1375858358-15070-1-git-send-email-wni@nvidia.com>
 <1375858358-15070-3-git-send-email-wni@nvidia.com>
Message-ID: <52026FEE.9070003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 12:52 AM, Wei Ni wrote:
> Enable thermal sensor nct1008 for t114 dalmore.

Wei, I assume this patch doesn't depend on any of the other LM90-related
patches you've sent; I can simply apply it right away?

Is the LM90 DT binding fully documented somewhere, including the
vdd-supply property?
