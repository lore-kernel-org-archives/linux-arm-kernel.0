From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Jan 2015 14:59:03 -0800
Subject: [PATCH 1/1] ARM: multi_v7_defconfig: Enable Exynos5420
 Multi-Cluster PM support
In-Reply-To: <1422456020-10975-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1422456020-10975-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20150128225903.GA3177@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 03:40:20PM +0100, Javier Martinez Canillas wrote:
> The Exynos5420 cluster power management support allowing Exynos
> 5420/5422/5800 machines to power up and down the secondary CPUs.
> 
> Without this option enabled, the secondary CPUs are not brought
> up on boot and the following error is shown:
> 
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> Setting up static identity map for 0x40938e90 - 0x40938f28
> ARM CCI driver probed
> CPU1: failed to boot: -38
> CPU2: failed to boot: -38
> CPU3: failed to boot: -38
> CPU4: failed to boot: -38
> CPU5: failed to boot: -38
> CPU6: failed to boot: -38
> CPU7: failed to boot: -38
> Brought up 1 CPUs
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Applied, thanks.


-Olof
