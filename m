From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 17:15:05 +0200
Subject: [PATCH 06/15] mfd: Register the ab8500 from db8500-prcmu using
 the MFD API
In-Reply-To: <1340197011-5435-7-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629151505.GI22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jun 20, 2012 at 01:56:42PM +0100, Lee Jones wrote:
> Hierarchically, the AB8500 is a child of the DB8500 PRCMU. So now that
> Device Tree is being used and MFD core code is Device Tree aware, we
> can simply register DB8500 PRCMU from Device Tree in the normal way
> then allow the DB8500 PRCMU driver to register the AB8500 as a simple
> MFD device at probe time.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c |    2 --
>  drivers/mfd/ab8500-core.c          |   12 ------------
>  drivers/mfd/db8500-prcmu.c         |   15 +++++++++++++++
>  3 files changed, 15 insertions(+), 14 deletions(-)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
