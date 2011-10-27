From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 Oct 2011 13:20:55 +0100
Subject: [PATCH v3 4/4] regulator: map consumer regulator based on
	device tree
In-Reply-To: <1319702185-16108-5-git-send-email-rnayak@ti.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-5-git-send-email-rnayak@ti.com>
Message-ID: <20111027122054.GC10089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:26:25PM +0530, Rajendra Nayak wrote:
> Device nodes in DT can associate themselves with one or more
> regulators/supply by providing a list of phandles (to regulator nodes)
> and corresponding supply names.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
