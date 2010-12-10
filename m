From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Dec 2010 10:52:13 +0000
Subject: [PATCH 1/9] regulators: Moved define for number of regulators
	in ab8500
In-Reply-To: <1291975728-12525-2-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1291975728-12525-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1291975728-12525-2-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <20101210105213.GB3200@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 11:08:40AM +0100, Bengt Jonsson wrote:
> The define for number of regulators is moved from ab8500-core to
> ab8500-regulator so that the regulator driver can be updated
> independently of ab8500-core. This also changes the platform
> configuration structure of ab8500-core so that it contains a
> pointer to the regulator_init_data array plus number of
> regulators instead of an fixed size array of pointers to
> regulator_init_data.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
