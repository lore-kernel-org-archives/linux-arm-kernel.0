From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 30 Jun 2016 08:52:35 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix debug string
In-Reply-To: <1467222291-13045-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1467222291-13045-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160630032235.GK14945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 07:44:51PM +0200, Alexandre Belloni wrote:
> mbr_ds is an integer, don't use %pad to print it.

Applied, thanks

-- 
~Vinod
