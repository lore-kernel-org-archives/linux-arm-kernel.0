From: olof@lixom.net (Olof Johansson)
Date: Tue, 24 Jan 2012 00:42:49 -0800
Subject: [PATCH V2 1/4] ARM: dt: tegra: Add Tegra APB DMA device tree
 binding
In-Reply-To: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
References: <1326323397-23931-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120124084249.GA14682@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 11, 2012 at 04:09:54PM -0700, Stephen Warren wrote:
> Document binding, and add the node to tegra*.dtsi.
> 
> The driver isn't actually instantiated from this node yet, but the I2S
> binding will rely on being able to refer to the APB DMA node using a
> phandle.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> v2: Added this to tegra30.dtsi too. Fixed interrupt IDs. Fixed reg to
> include all the per-channel registers.

Thanks, applied 1-4.


-Olof
