From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 May 2015 11:10:46 +0530
Subject: [PATCH v5 8/8] ARM: DTS: dra7x: Integrate sDMA crossbar
In-Reply-To: <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20150504054046.GZ3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 12:35:54PM +0300, Peter Ujfalusi wrote:
> The sDMA requests are routed through the DMA crossbar and without the
> crossbar only peripherals using DMA request 0-127 can be used.
> 
Need an ACK from ARM folks before I apply this and the DT ones too please

-- 
~Vinod
