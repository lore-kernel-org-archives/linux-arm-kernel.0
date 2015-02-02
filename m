From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 02 Feb 2015 13:47:28 +0300
Subject: [PATCH v1] ahci_xgene: Fix the dma state machine lockup for the
 ATA_CMD_SMART PIO mode command.
In-Reply-To: <1422872328-16700-2-git-send-email-stripathi@apm.com>
References: <1422872328-16700-1-git-send-email-stripathi@apm.com>
 <1422872328-16700-2-git-send-email-stripathi@apm.com>
Message-ID: <54CF55C0.5080404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/2/2015 1:18 PM, Suman Tripathi wrote:

> This patch addresses the issue with ATA_CMD_SMART pio mode
> command for enumeration and device detection with ATA devices.
> The X-Gene AHCI controller has an errata in which it cannot clear
> the BSY bit after the PIO setup FIS. The dma state machine enters
> CMFatalErrorUpdate state and locks up. It is the same issue as
> in the patch(Commit ID : 2a0bdff6b958d1b2523d2754b6cd5e0ea4053016).

    Just "in the commit 2a0bdff6b958d1b2523d2754b6cd5e0ea4053016". And you 
also need to specify the commit's summary line in parens.

> Signed-off-by: Suman Tripathi <stripathi@apm.com>

WBR, Sergei
