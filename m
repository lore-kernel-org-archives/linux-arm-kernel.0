From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 29 Sep 2014 11:14:03 +0300
Subject: [PATCH v6 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
In-Reply-To: <5425CC6F.2020309@kapsi.fi>
References: <1411724593-4037-1-git-send-email-cyndis@kapsi.fi>
 <1411724593-4037-5-git-send-email-cyndis@kapsi.fi>
 <20140926114533.GN31106@ulmo> <5425CC6F.2020309@kapsi.fi>
Message-ID: <20140929081403.GF25537@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> >>+struct tegra_tsensor_configuration {
> >>+	u32 tall, tsample, tiddq_en, ten_count;
> >>+	u32 pdiv, tsample_ate, pdiv_ate;
> >
> >What's the significance of the "ate" suffix?
> 
> Again, no idea.

I presume it's Automated Test Equipment refering to the device to test silicon
coming back from the fab.

Cheers,

Peter.
