From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 Aug 2012 10:58:45 -0600
Subject: [PATCH] ARM: dt: tegra: whistler: add regulators
In-Reply-To: <1344017484-29395-1-git-send-email-swarren@wwwdotorg.org>
References: <1344017484-29395-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <502BD545.1010300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 12:11 PM, Stephen Warren wrote:
> Whistler uses a Maxim 8907 regulator. Instantiate this.
> 
> The voltage settings were derived from the schematic. The only exception
> is the BBAT voltage; the schematic says 1.2v, but the HW can't go that
> low, so use the HW default of 2.4v instead.
> 
> Almost all regulators list all driven supply signal names in their
> regulator-names property. The exception is nvvdd_sv3, which is in turn
> named 12 more different names on the schematic, so these were omitted
> for brevity.

Applied to Tegra's for-3.7/dt branch.
