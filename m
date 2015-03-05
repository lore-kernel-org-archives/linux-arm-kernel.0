From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 5 Mar 2015 14:30:30 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix for chan conf simplification
In-Reply-To: <1423755030-14257-1-git-send-email-ludovic.desroches@atmel.com>
References: <1423755030-14257-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20150305090030.GB2613@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 04:30:30PM +0100, Ludovic Desroches wrote:
> When simplificating the channel configuration, the cyclic case has been
> forgotten. It leads to use bad configuration causing many bugs.
Applied, thanks

-- 
~Vinod
