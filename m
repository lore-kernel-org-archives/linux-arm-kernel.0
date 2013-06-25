From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 25 Jun 2013 21:40:04 +0530
Subject: [RFC PATCH v2 05/12] dmaengine: PL08x: Add support for
 different maximum transfer size
In-Reply-To: <1371933764-24875-6-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-6-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130625161003.GQ23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42:37PM +0200, Tomasz Figa wrote:
> PL080S has separate register to store transfer size in, allowing single
> transfer to be much larger than in standard PL080.
> 
> This patch makes the amba-pl08x driver aware of this and removes writing
> transfer size to reserved bits of CH_CONTROL register on PL080S, which
> was not a problem witn transfer sizes fitting the original bitfield
> of PL080, but now would overwrite other fields.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
