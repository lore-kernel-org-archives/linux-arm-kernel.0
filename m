From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 22 Feb 2018 15:12:17 +0100
Subject: [PATCH v6 0/2] staging: fsl-mc: Move bus driver out of staging
In-Reply-To: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
Message-ID: <20180222141217.GA19330@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 08:07:41AM -0600, Bogdan Purcareata wrote:
> Previous submission: https://lkml.org/lkml/2018/1/26/215
> 
> Split the code into moving out the core bus infrastructure separate from
> the irqchip glue code. Add a Kconfig dependency on ARM_GIC_V3_ITS.
> Integrate the documentation with the kernel build system.
> 
> This patchset only handles moving the fsl-mc bus core out of staging.
> The remaining objects (DPBP, DPCON) and drivers (dpio, dpaa2-eth) will
> be moved out in subsequent patches.

Now applied, nice work everyone.

greg k-h
