From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Oct 2011 15:38:12 -0700
Subject: [PATCH v4 2/4] arm/dt: Tegra: Add pinmux node to tegra20.dtsi
In-Reply-To: <1318371375-4083-2-git-send-email-swarren@nvidia.com>
References: <1318371375-4083-1-git-send-email-swarren@nvidia.com>
	<1318371375-4083-2-git-send-email-swarren@nvidia.com>
Message-ID: <20111012223812.GB25128@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 04:16:13PM -0600, Stephen Warren wrote:
> Add a pinmux node to tegra20.dtsi in order to instantiate the future
> pinmux device.
> 
> v2: Specify reg property precisely; don't just point at the whole APB_MISC
> register range.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.2/features.                                                                                                                                                   


-Olof
