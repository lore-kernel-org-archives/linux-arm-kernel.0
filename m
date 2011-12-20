From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 17:58:43 -0800
Subject: [PATCH V2 3/4] arm/dt: tegra: Use new compatible value for DVC
 I2C controller
In-Reply-To: <1324189772-26914-3-git-send-email-swarren@nvidia.com>
References: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
 <1324189772-26914-3-git-send-email-swarren@nvidia.com>
Message-ID: <20111220015843.GC27789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 11:29:31PM -0700, Stephen Warren wrote:
> Update the device tree to indicate which I2C controller is the DVC
> controller. AUXDATA needs to be updated too, since the compatible
> value changed.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.3/dt.


-Olof
