From: horms@verge.net.au (Simon Horman)
Date: Fri, 28 Jun 2013 17:26:49 +0900
Subject: [PATCH 3/3] ARM: shmobile: ape6evm: add CPUFreq support
In-Reply-To: <1372326479-15028-4-git-send-email-g.liakhovetski@gmx.de>
References: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
 <1372326479-15028-4-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130628082649.GD29517@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 11:47:58AM +0200, Guennadi Liakhovetski wrote:
> This patch adds OPPs to the CA15 DT node and a max8973 DT node to support
> clock and voltage scaling, using the cpufreq-cpu0 CPUFreq driver.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued up for v3.12 in the dt branch.
