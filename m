From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:22:04 +0100
Subject: [PATCH v7 8/8] drivers: cpuidle: initialize Exynos driver
 through DT
In-Reply-To: <1407945127-27554-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-9-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140818142204.GJ20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 04:52:07PM +0100, Lorenzo Pieralisi wrote:
> With the introduction of DT based idle states, CPUidle drivers for
> ARM can now initialize idle states data through properties in the device
> tree.
> 
> This patch adds code to the Exynos CPUidle driver to dynamically
> initialize idle states data through the updated device tree source
> files.
> 
> Cc: Chander Kashyap <k.chander@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
