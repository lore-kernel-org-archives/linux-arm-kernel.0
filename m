From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 30 May 2016 10:48:09 +0530
Subject: [PATCH 1/3] dmaengine: at_xdmac: align descriptors on 64 bits
In-Reply-To: <1463064854-6719-1-git-send-email-ludovic.desroches@atmel.com>
References: <1463064854-6719-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20160530051808.GJ16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 04:54:08PM +0200, Ludovic Desroches wrote:
> Having descriptors aligned on 64 bits allows update CNDA and CUBC in an
> atomic way.

Applied all, thanks

-- 
~Vinod
