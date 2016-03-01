From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 1 Mar 2016 08:55:39 +0000 (UTC)
Subject: [PATCH 02/11] ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0,
 tptc1
In-Reply-To: <1456411827-23962-3-git-send-email-peter.ujfalusi@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
 <1456411827-23962-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.02.1603010855210.14948@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2016, Peter Ujfalusi wrote:

> Add hwmod data for the eDMA blocks:
>  - TPCC: Third-party channel controller
>  - TPTC0: Third-party transfer controller 0
>  - TPTC1: Third-party transfer controller 1
> 
> The TPCC is following it's clock and power domain. This means that
> the hwmod can not control it's status.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, queued.


- Paul
