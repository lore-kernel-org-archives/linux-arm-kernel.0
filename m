From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 16:53:59 +0200
Subject: [PATCH 02/15] mfd: Generically describe interactions with the
 DB8500 PRCMU
In-Reply-To: <1340197011-5435-3-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629145359.GE22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jun 20, 2012 at 01:56:38PM +0100, Lee Jones wrote:
> There is only one method used to communicate with the DB8500 PRCMU, via I2C.
> Now this can be assumed, there is no requirement to specify the protocol in
> the function name. This patch removes protocol specifics and uses a more
> generic naming convention.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c    |   12 ++++++------
>  drivers/mfd/ab8500-debugfs.c |    6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
