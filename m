From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 Oct 2011 09:55:02 +0100
Subject: [PATCH 1/3] regulator: twl: adapt twl-regulator driver to dt
In-Reply-To: <1319702674-16304-2-git-send-email-rnayak@ti.com>
References: <1319702674-16304-1-git-send-email-rnayak@ti.com>
	<1319702674-16304-2-git-send-email-rnayak@ti.com>
Message-ID: <20111027085501.GA6641@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:34:32PM +0530, Rajendra Nayak wrote:

> +	select OF_REGULATOR if OF

We should probably just not have OF_REGULATOR or do the select from the
core, this is just going to end up being noisy.
