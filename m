From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 21 Jun 2013 09:33:01 +0200
Subject: [PATCH] dmaengine: ste_dma40: Declare memcpy config as static
In-Reply-To: <20130621031000.GB23141@intel.com>
References: <1371719859-4600-1-git-send-email-fabio.baltieri@linaro.org>
 <20130621031000.GB23141@intel.com>
Message-ID: <20130621073301.GA19353@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 08:40:00AM +0530, Vinod Koul wrote:
> On Thu, Jun 20, 2013 at 11:17:39AM +0200, Fabio Baltieri wrote:
> > Fix sparse warnings:
> > 
> > drivers/dma/ste_dma40.c:81:26: warning: symbol 'dma40_memcpy_conf_phy' was not declared. Should it be static?
> > drivers/dma/ste_dma40.c:95:26: warning: symbol 'dma40_memcpy_conf_log' was not declared. Should it be static?
> > 
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
> I guess this would be dependent on recent ste_dma40 patches so best way is
> Linus's tree, right?

Yes, but I'm not sure Linus is going to send a third pull request for
dma40 so maybe I should just resend my last two dma40 patches for
arm-soc directly.

Thanks for the Ack.

Fabio

-- 
Fabio Baltieri
