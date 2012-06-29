From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 16:47:46 +0200
Subject: [PATCH 05/14] mfd: Enable DT probing of the DB8500 PRCMU
In-Reply-To: <1339428307-3850-6-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20120629144746.GA22806@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Jun 11, 2012 at 04:24:58PM +0100, Lee Jones wrote:
> This patch adds the correct compatible string for use during Device Tree
> population. Without it the DB8500 PRCMU will not be probed.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |    5 +++++
>  1 file changed, 5 insertions(+)
Patch applied now, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
