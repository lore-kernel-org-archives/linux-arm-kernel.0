From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 5 Aug 2016 09:04:11 +0530
Subject: [PATCH 1/3] dt/bindings: arm-pl330: add description of
 arm,pl330-periph-burst
In-Reply-To: <1470365602-32586-2-git-send-email-shawn.lin@rock-chips.com>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
 <1470365602-32586-2-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20160805033410.GJ9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 10:53:20AM +0800, Shawn Lin wrote:
> This patch adds the "arm,pl330-periph-burst" for arm-pl330 to
> support busrt mode.

why should this be DT property. Only reason I can think of if some hw
versions support this and some won't.

If all are supporting, please enable it everywhere for obvious reasons.

-- 
~Vinod
