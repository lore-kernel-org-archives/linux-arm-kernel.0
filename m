From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 22 May 2014 23:44:54 +0300
Subject: [PATCH] ARM: imx: introduce function imx_free_mx3_camera
In-Reply-To: <1400781080-6117-1-git-send-email-emilgoode@gmail.com>
References: <1400781080-6117-1-git-send-email-emilgoode@gmail.com>
Message-ID: <20140522204453.GN15585@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 07:51:19PM +0200, Emil Goode wrote:
> We forgot to free pdev->dev.dma_mask on error after
> having called the imx_alloc_mx3_camera function.
> This patch introduces the imx_free_mx3_camera function
> that adds the missing kfree call and is practical for
> future usage with imx_alloc_mx3_camera().
> 
> Signed-off-by: Emil Goode <emilgoode@gmail.com>

Fantastic.  Thanks for this.  :)

regards,
dan carpenter
