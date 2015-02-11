From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Feb 2015 11:36:52 +0000
Subject: [PATCH v3 1/2] coresight: Adding coresight support for arm64
 architecture
In-Reply-To: <1423629085-1044-1-git-send-email-mathieu.poirier@linaro.org>
References: <1423629085-1044-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20150211113651.GC9058@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 09:31:24PM -0700, mathieu.poirier at linaro.org wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Most CoreSight blocks are 64-bit ready.  As such move configuration
> entries from "arch/arm/Kconfig.config" to the driver's subdirectory
> and source the newly created Kconfig from architecture specific
> Kconfig.debug files.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> Change for v3:
>   - Separating Kconfig work from compilation warnings fixes.

Nitpick: merge the compilation warnings fix first so that we don't get
them once the Kconfig patch is merged for arm64.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
