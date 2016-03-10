From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 10 Mar 2016 16:37:19 +0530
Subject: [RESEND PATCH] dmaengine: at_xdmac: fix residue computation
In-Reply-To: <1457601481-17405-1-git-send-email-ludovic.desroches@atmel.com>
References: <1457601481-17405-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160310110718.GE11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:17:55AM +0100, Ludovic Desroches wrote:
> When computing the residue we need two pieces of information: the current
> descriptor and the remaining data of the current descriptor. To get
> that information, we need to read consecutively two registers but we
> can't do it in an atomic way. For that reason, we have to check manually
> that current descriptor has not changed.

Applied, thanks


-- 
~Vinod
