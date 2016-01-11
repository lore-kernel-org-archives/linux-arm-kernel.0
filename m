From: tj@kernel.org (Tejun Heo)
Date: Mon, 11 Jan 2016 11:10:11 -0500
Subject: [PATCH 0/2] ata: Introduce the AHCI_HFLAG_EDGE_IRQ_BROKEN in
 libahci and enabling it for ahci_xgene driver.
In-Reply-To: <1452506763-18649-1-git-send-email-stripathi@apm.com>
References: <1452506763-18649-1-git-send-email-stripathi@apm.com>
Message-ID: <20160111161011.GD1898@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 03:36:01PM +0530, Suman Tripathi wrote:
> This patch set implements a workaround for an errate in the APM
> X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
> misses the edge interrupt from the PORT_IRQ_STAT when clearing the
> HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
> cycle.

Heh, I don't know why but I had to pull this posting out of spam too.
For some reason, gmail thought these are spams.

-- 
tejun
