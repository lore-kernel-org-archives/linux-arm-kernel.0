From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 3 Nov 2016 13:15:09 +0000
Subject: [PATCH] dmaengine: st_fdma: Update st_fdma to 'depends on
 REMOTEPROC'.
In-Reply-To: <1477039465-31121-1-git-send-email-peter.griffin@linaro.org>
References: <1477039465-31121-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1478178908.6505.28.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-21 at 09:44 +0100, Peter Griffin wrote:
> During randconfig builds you can get the following warning
> "warning: (ST_FDMA) selects ST_SLIM_REMOTEPROC which has unmet direct
> ?dependencies (REMOTEPROC)"
> 
> randconfig builds should always build without any warnings so
> update fdma to depend on REMOTEPROC so this can not happen.

Applied, thanks

-- 
~Vinod
