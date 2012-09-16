From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 17 Sep 2012 01:45:01 +0200
Subject: [PATCH 16/19] mfd: Provide the tc3589x with its own IRQ domain
In-Reply-To: <1347016499-29354-17-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-17-git-send-email-lee.jones@linaro.org>
Message-ID: <20120916234501.GP3647@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Sep 07, 2012 at 12:14:56PM +0100, Lee Jones wrote:
> In preparation for Device Tree enablement all IRQ controllers
> should control their own IRQ domain. This patch provides just
> that.
> 
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/tc3589x.c       |   73 ++++++++++++++++++++++++++++---------------
>  include/linux/mfd/tc3589x.h |    1 +
>  2 files changed, 48 insertions(+), 26 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
