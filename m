From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 16 May 2017 10:02:40 +0530
Subject: [PATCH v8 0/4] Broadcom SBA RAID support
In-Reply-To: <1494824695-21797-1-git-send-email-anup.patel@broadcom.com>
References: <1494824695-21797-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170516043239.GH15061@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 10:34:51AM +0530, Anup Patel wrote:
> The Broadcom SBA RAID is a stream-based device which provides
> RAID5/6 offload.
> 
> It requires a SoC specific ring manager (such as Broadcom FlexRM
> ring manager) to provide ring-based programming interface. Due to
> this, the Broadcom SBA RAID driver (mailbox client) implements
> DMA device having one DMA channel using a set of mailbox channels
> provided by Broadcom SoC specific ring manager driver (mailbox
> controller).
> 
> The Broadcom SBA RAID hardware requires PQ disk position instead
> of PQ disk coefficient. To address this, we have added raid_gflog
> table which will help driver to convert PQ disk coefficient to PQ
> disk position.

Applied, now

-- 
~Vinod
