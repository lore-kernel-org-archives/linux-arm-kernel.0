From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 25 Jun 2013 21:04:40 +0530
Subject: [RFC PATCH v2 02/12] dmaengine: PL08x: Add support for
 different offset of CONFIG register
In-Reply-To: <1371933764-24875-3-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130625153440.GP23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42:34PM +0200, Tomasz Figa wrote:
> Some variants of PL08x (namely PL080S, found in Samsung S3C64xx SoCs)
> have CONFIG register at different offset. This patch makes the driver
> use offset from vendor data struct.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
