From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 21 Mar 2017 14:00:52 +0530
Subject: [PATCH v6 0/4] Broadcom SBA RAID support
In-Reply-To: <1488793408-25592-1-git-send-email-anup.patel@broadcom.com>
References: <1488793408-25592-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <20170321083052.GY2843@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 03:13:24PM +0530, Anup Patel wrote:
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
> 
> This patchset is based on Linux-4.11-rc1 and depends on patchset
> "[PATCH v5 0/2] Broadcom FlexRM ring manager support"

Okay I applied and was about to push when I noticed this :(

So what is the status of this..?


-- 
~Vinod
