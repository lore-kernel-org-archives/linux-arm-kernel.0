From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 21 Sep 2017 20:13:41 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable CMA options
In-Reply-To: <20170920180132.4373-1-s-anna@ti.com>
References: <20170920180132.4373-1-s-anna@ti.com>
Message-ID: <758ebb8d-cdf5-4cdc-253b-b1eb8e2f7c61@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 September 2017 11:31 PM, Suman Anna wrote:
> Enable the CMA and DMA_CMA Kconfig options by default for
> Davinci platforms. Davinci remoteproc driver is one of the
> modules that depends on these options, and this allows the
> driver to be made visible for selection with menuconfig.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> Hi Sekhar,
> 
> Here's the patch that enables CMA as per your request. Patch based
> on your v4.15/defconfig branch.

Applied! I guess you will be sending another patch enabling the
remoteproc driver itself?

Thanks,
Sekhar
