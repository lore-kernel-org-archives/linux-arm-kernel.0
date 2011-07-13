From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 13 Jul 2011 11:51:41 -0700
Subject: [PATCH] ARM: Tegra: Trimslice: Tri-state DAP2 pinmux
In-Reply-To: <20110713180058.GB27828@avionic-0098.mockup.avionic-design.de>
References: <1310579091-7424-1-git-send-email-swarren@nvidia.com>
	<20110713180058.GB27828@avionic-0098.mockup.avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E834793@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Wednesday, July 13, 2011 12:01 PM:
> Stephen Warren wrote:
> > DAP2 is used for a bunch of GPIOs. Not tri-stating the pins means audio
> > signals get sent out there, and this ends up resetting USB and breaking
> > SDHCI too.
...
> > -	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
> > +	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
> 
> The patch subject and description say that DAP2 is tristated, not DAP3.

Oops. I've fixed that locally and will repost once Mike acks it.

Thanks!

-- 
nvpublic
