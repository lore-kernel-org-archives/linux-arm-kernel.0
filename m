From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 13:51:57 -0800
Subject: [PATCH V2 2/2] ARM: dt: Add SD controller configuration to Tegra
 Cardhu
In-Reply-To: <1328138997-25665-2-git-send-email-swarren@nvidia.com>
References: <1328138997-25665-1-git-send-email-swarren@nvidia.com>
 <1328138997-25665-2-git-send-email-swarren@nvidia.com>
Message-ID: <20120226215157.GB11189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 04:29:57PM -0700, Stephen Warren wrote:
> Cardhu uses Tegra's SD ports as follows:
> SDMMC1: User SD slot, with GPIOs for power, CD, and WP.
> SDMMC2: Not used
> SDMMC3: WiFi (currently disabled pending future investigation)
> SDMMC4: Internal eMMC
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.4/dt


-Olof
