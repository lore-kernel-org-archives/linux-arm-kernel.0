From: tj@kernel.org (Tejun Heo)
Date: Thu, 21 Aug 2014 09:14:39 -0500
Subject: [PATCH v7 3/3] ahci_xgene: Fix the link down in first attempt
 for the APM X-Gene SoC AHCI SATA host controller driver.
In-Reply-To: <CAOHikRB6Kfg82ewx6e-a6SCvjt_ipSKuXLciS=nHA1EpZzXrYA@mail.gmail.com>
References: <1408429911-1406-1-git-send-email-stripathi@apm.com>
 <1408429911-1406-4-git-send-email-stripathi@apm.com>
 <20140819154912.GC16480@htj.dyndns.org>
 <CAOHikRB6Kfg82ewx6e-a6SCvjt_ipSKuXLciS=nHA1EpZzXrYA@mail.gmail.com>
Message-ID: <20140821141439.GB1766@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 01:48:00PM +0530, Suman Tripathi wrote:
> [suman] : The problem is COMRESET didn't failed. I meant the hardreset is
> successful (return 0) but the device is not detected even if device is
> present due to speed negotiation failure. For that reason I check for the
> Pxstatus and retried.

Alright, please update the comment to explain what's going on.

Thanks.

-- 
tejun
