From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 17:11:04 +0200
Subject: [PATCH 05/15] mfd: db8500-prcmu: Register devices using the
 newly DT:ed MFD API
In-Reply-To: <1340197011-5435-6-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629151104.GH22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Jun 20, 2012 at 01:56:41PM +0100, Lee Jones wrote:
> Now the MFD API is Device Tree aware we can use it for platform
> registration again, even when booting with DT enabled. To aid in
> Device Node pointer allocation we provide each cell with the
> associative compatible string.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c       |   14 +++++++-------
>  drivers/regulator/db8500-prcmu.c |    6 ------
>  2 files changed, 7 insertions(+), 13 deletions(-)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
