From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 7 Aug 2014 21:53:08 +0530
Subject: [PATCHv2] dma: at_hdmac: fix invalid remaining bytes detection
In-Reply-To: <1406911906-397-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1406911906-397-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140807162308.GD9692@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 06:51:46PM +0200, Alexandre Belloni wrote:
> Found using smatch:
> drivers/dma/at_hdmac.c:299 atc_get_bytes_left() warn: unsigned
> 'atchan->remain_desc' is never less than zero.

Applied, thanks

-- 
~Vinod
