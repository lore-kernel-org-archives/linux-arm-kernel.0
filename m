From: tj@kernel.org (Tejun Heo)
Date: Tue, 27 Jan 2015 13:19:50 -0500
Subject: [PATCH] ahci_xgene: Fix the dma state machine lockup for the
 ATA_CMD_SMART PIO mode command.
In-Reply-To: <1422381371-11361-2-git-send-email-stripathi@apm.com>
References: <1422381371-11361-1-git-send-email-stripathi@apm.com>
 <1422381371-11361-2-git-send-email-stripathi@apm.com>
Message-ID: <20150127181950.GE12314@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:26:11PM +0530, Suman Tripathi wrote:
> This patch addresses the issue with ATA_CMD_SMART pio mode
> command for enumeration and device detection with ATA devices.It is the
> same issue as in patch
> 
> www.spinics.net/lists/linux-ide/msg49092.html

The link is broken.  Can you please include at least a brief
explanation of the problem and preferably link to something more
permanant (commit ID, http://lkml.kernel.org/g/MSG_ID)?

Thanks.

-- 
tejun
