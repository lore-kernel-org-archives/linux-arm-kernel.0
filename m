From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 9 May 2012 16:30:51 +0200
Subject: [PATCH 09/15] drivers/mfd: Enable Device Tree support for the
 db8500-prcmu
In-Reply-To: <1336155805-18554-10-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20120509143051.GG1794@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, May 04, 2012 at 07:23:19PM +0100, Lee Jones wrote:
> This patch will enable probing to occur during a Device Tree enabled
> boot. The IRQ base is expected to be located in and will be fetched
> from the DT itself. We also prevent any of the db8500 regulators
> from being registered here, as they will be enabled via DT instead.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |   29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
