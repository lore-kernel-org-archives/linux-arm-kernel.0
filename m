From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 18 Mar 2015 22:13:38 +0530
Subject: [PATCH 08/35 linux-next] dma: constify of_device_id array
In-Reply-To: <1426533469-25458-9-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-9-git-send-email-fabf@skynet.be>
Message-ID: <20150318164338.GP32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 08:17:14PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
> 
Applied, thanks

-- 
~Vinod
