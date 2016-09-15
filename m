From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 15 Sep 2016 21:14:41 +0530
Subject: [PATCH 1/2 v3] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
In-Reply-To: <20160915053731.25263-1-sr@denx.de>
References: <20160915053731.25263-1-sr@denx.de>
Message-ID: <20160915154440.GU13920@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 07:37:30AM +0200, Stefan Roese wrote:
> This patch provides a stub function for mvebu_mbus_get_io_win_info(),
> which will be used for all non-Orion (ARM32 MVEBU) platforms for
> compile test coverage.
> 
> On such platforms this function will return an error so that drivers
> might detect a potential problem.

Applied both,

Thanks
-- 
~Vinod
