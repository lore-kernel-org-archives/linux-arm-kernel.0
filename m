From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jan 2012 20:18:56 -0800
Subject: [PATCH] ARM: tegra: initialize basic system clocks
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A404@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A286@HQMAIL01.nvidia.com>
 <1326212538-15419-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A404@HQMAIL01.nvidia.com>
Message-ID: <20120119041856.GC7145@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 09:23:52AM -0800, Stephen Warren wrote:
> Peter De Schrijver wrote at Tuesday, January 10, 2012 9:22 AM:
> > Initialize basic system clocks and provide a auxdata table to allow some
> > peripheral drivers to find their clocks.
> ...
> > This should fix the hang you observed when sdhci_add_host() fails.
> 
> Yes, it does. This plus the Tegra30 clock patch series you posted stops
> I2C and SDHCI drivers complaining about a lack of clocks during boot,
> which is a great step forwards, even if SDHCI doesn't yet initialize
> successfully. Thanks.
> 
> This patch and the clock series:
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>

Applied.

Peter, in the future please provide at least a one-sentence description of the
patch in the patch description. "ARM: tegra: enable tegra30 clock framework"
had no actualy patch description body so I added a simple one. It's a trivial
patch but it's a good habit to always have something there.


Thanks!

-Olof
