From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jun 2013 08:10:39 +0530
Subject: [PATCH 2/8] at_hdmac: prepare clk before calling enable
In-Reply-To: <51C2B2B8.2040104@atmel.com>
References: <1371640263-9268-1-git-send-email-b.brezillon@overkiz.com>
 <1371640494-9472-1-git-send-email-b.brezillon@overkiz.com>
 <51C2B2B8.2040104@atmel.com>
Message-ID: <20130621024039.GA23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 09:43:52AM +0200, Nicolas Ferre wrote:
> On 19/06/2013 13:14, Boris BREZILLON :
> >Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> >avoid common clk framework warnings.
> >
> >Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> BTW Vinod, it seems that we have several slave-dma patches pending:
> do you want me to collect them and send you a pull-request for 3.11?
I think those are the DT binding one, right? Sorry have been quite busy and
travelling. I could use the help right now...

--
~Vinod
