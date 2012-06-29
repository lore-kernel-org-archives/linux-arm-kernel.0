From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 16:51:46 +0200
Subject: [PATCH 01/15] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <1340197011-5435-2-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629145146.GD22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jun 20, 2012 at 01:56:37PM +0100, Lee Jones wrote:
> As the AB8500 is an IRQ controller in its own right, here we provide
> the AB8500 driver with IRQ domain support. This is required if we wish
> to reference any of its IRQs from a platform's Device Tree.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Naga Radheshy <naga.radheshy@stericsson.com>
> Cc: Mattias Wallin <mattias.wallin@stericsson.com>
> Cc: Daniel Willerud <daniel.willerud@stericsson.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/Kconfig               |    1 +
>  drivers/mfd/ab8500-core.c         |  130 ++++++++++++++++++++-----------------
>  include/linux/mfd/abx500/ab8500.h |    5 ++
>  3 files changed, 76 insertions(+), 60 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
