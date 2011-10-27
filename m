From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 Oct 2011 13:20:24 +0100
Subject: [PATCH v3 3/4] regulator: pass additional of_node to
	regulator_register()
In-Reply-To: <1319702185-16108-4-git-send-email-rnayak@ti.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-4-git-send-email-rnayak@ti.com>
Message-ID: <20111027122024.GB10089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:26:24PM +0530, Rajendra Nayak wrote:

> With device tree support for regulators, its needed that the
> regulator_dev->dev device has the right of_node attached.
> To be able to do this add an additional parameter to the
> regulator_register() api, wherein the dt-adapted driver can
> then pass this additional info onto the regulator core.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
