From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 15:37:49 -0700
Subject: [PATCH v4 1/4] arm/tegra: Prep boards for gpio/pinmux conversion
	to pdevs
In-Reply-To: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111012223749.GA25128@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 04:16:12PM -0600, Stephen Warren wrote:
> The Tegra GPIO driver will be converted from static registration via
> postcore_initcall() to be a platform device later in this patch series.
> A new Tegra pinmux platform device will also be added.
> 
> Prepare for this by modifying all boards to register the appropriate
> platform devices before-hand, so that when the drivers are converted,
> those devices will be probed, and git bisectability will be maintained.
> 
> v2: Add resource definitions for GPIO and pinmux
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.2/features.


-Olof
