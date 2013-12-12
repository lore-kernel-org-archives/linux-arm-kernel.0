From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 13:16:14 -0700
Subject: [PATCH v5 3/3] ARM: tegra: correct Colibri T20 regulator settings
In-Reply-To: <47b41f2de9c2651fbd2cded53c634a533d2740c1.1386333697.git.stefan@agner.ch>
References: <cover.1386333697.git.stefan@agner.ch>
 <47b41f2de9c2651fbd2cded53c634a533d2740c1.1386333697.git.stefan@agner.ch>
Message-ID: <52AA198E.3050304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2013 05:51 AM, Stefan Agner wrote:
> Set the parent of the regulators LDO2 to LDO9 according to the
> schematic. Set the base voltage to 3.3V, there is only 3.3V on the
> module itself.
> 
> Set the Core and CPU voltage to the specified voltages of 1.2V and
> 1.0V respectivly.
> 
> LDO6 should deliver 2.85V. The attached peripherals were not in
> use so far.

I've applied patch 3/3 only to Tegra's for-3.14/dt branch.
