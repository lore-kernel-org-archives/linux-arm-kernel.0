From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 19 Oct 2015 11:37:38 -0700
Subject: [PATCH V2 01/30] coresight: etm3x: moving etm_readl/writel to
 header file
In-Reply-To: <1445192687-24112-2-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20151019183738.GA1336@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 18, 2015 at 12:24:18PM -0600, Mathieu Poirier wrote:
> Moving functions etm_readl/writel to file "coresight-etm.h"
> for access by code outside of the main ETM3x driver.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm.h   | 29 +++++++++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-etm3x.c | 29 ---------------------------
>  2 files changed, 29 insertions(+), 29 deletions(-)

Can you remake this series use -M to 'git format-patch' so that we can
see the renames easier and they don't show up as 'delete and add'
patches?

thanks,

greg k-h
