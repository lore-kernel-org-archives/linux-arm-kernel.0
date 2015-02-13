From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 13 Feb 2015 17:05:17 +0100
Subject: [PATCH] drm: atmel-hlcdc: remove useless pm_runtime_put_sync in
 probe
In-Reply-To: <1423841785-23105-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1423841785-23105-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150213160517.GA31574@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

On Fri, Feb 13, 2015 at 04:36:25PM +0100, Boris Brezillon wrote:
> Remove a useless pm_runtime_put_sync leading to unbalanced
> usage_count.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reported-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---

Indeed, this is actually a necessary fix for my "drm: atmel-hlcdc: PM 
support" series.

Tested-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Reviewed-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Sylvain
