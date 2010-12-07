From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Dec 2010 15:22:22 +0000
Subject: [PATCH v7 06/12] regulator: add driver for tps6524x regulator
In-Reply-To: <1291733522-3626-7-git-send-email-cyril@ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
	<1291733522-3626-7-git-send-email-cyril@ti.com>
Message-ID: <20101207152222.GD9689@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 09:51:56AM -0500, Cyril Chemparathy wrote:

> +static int set_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
> +{

Updates in the regulator tree mean that this will no longer build in
-next.  Given the difficulty that this series seems to be having
perhaps it would make sense to split out drivers such as this which have
nothing to do with SSP itself and get them into the next merge window?
