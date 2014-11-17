From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Nov 2014 14:01:24 +0530
Subject: [PATCH 5/7] dmaengine: at_xdmac: fix missing spin_unlock
In-Reply-To: <1415875965-6905-6-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
 <1415875965-6905-6-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20141117083124.GR24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 11:52:43AM +0100, Ludovic Desroches wrote:
> Lock taken when entering the function but unlock missing before it
> returns.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
I am adding reported to tag  here for Dan's report

-- 
~Vinod
