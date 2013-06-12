From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 15:04:21 -0600
Subject: [PATCH 1/3] ARM: tegra: enable audio on Dalmore
In-Reply-To: <1371058636-25244-1-git-send-email-swarren@wwwdotorg.org>
References: <1371058636-25244-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51B8E255.4030601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 11:37 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Dalmore uses the RT5640 audio CODEC. Instantiate this on the I2C bus.
> Enable the relevant Tegra I2C controller. Add the top-level "sound" node
> to hook everything together, and provide a "sound card" device.

Patches 1 and 2 applied to Tegra's for-3.11/dt branch, and patch 3
squashed into Tegra's for-3.11/defconfig branch.
