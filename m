From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:21:59 +0100
Subject: [PATCH v7 7/8] drivers: cpuidle: initialize big.LITTLE driver
 through DT
In-Reply-To: <1407945127-27554-8-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-8-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140818142159.GI20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 04:52:06PM +0100, Lorenzo Pieralisi wrote:
> With the introduction of DT based idle states, CPUidle drivers for ARM
> can now initialize idle states data through properties in the device tree.
> 
> This patch adds code to the big.LITTLE CPUidle driver to dynamically
> initialize idle states data through the updated device tree source file.
> 
> Cc: Chander Kashyap <k.chander@samsung.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 23 +++++++++++++++++++++++
>  drivers/cpuidle/Kconfig.arm                |  1 +
>  drivers/cpuidle/cpuidle-big_little.c       | 23 ++++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 1 deletion(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
