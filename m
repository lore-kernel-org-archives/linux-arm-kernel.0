From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 Oct 2011 13:18:00 +0100
Subject: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
In-Reply-To: <1319702185-16108-3-git-send-email-rnayak@ti.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-3-git-send-email-rnayak@ti.com>
Message-ID: <20111027121800.GA10089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:26:23PM +0530, Rajendra Nayak wrote:
> The fixed regulator driver uses of_get_fixed_voltage_config()
> to extract fixed_voltage_config structure contents from device tree.
> 
> Also add documenation for additional bindings for fixed
> regulators that can be passed through dt.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
