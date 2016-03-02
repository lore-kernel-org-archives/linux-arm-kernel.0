From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 Mar 2016 09:25:27 +0900
Subject: [PATCH 2/2] arm64: dts: r8a7795: Add CAN support
In-Reply-To: <1456737661-20538-3-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1456737661-20538-3-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <20160302002527.GG17986@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 09:21:01AM +0000, Ramesh Shanmugasundaram wrote:
> Adds CAN controller nodes for r8a7795.
> 
> Note: CAN channel register base address mentioned in R-Car Gen3 Hardware
> User Manual v0.5E is incorrect. The corrected base addresses are:
> 
> CAN Channel 0 - 0xe6c30000
> CAN Channel 1 - 0xe6c38000
> 
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

I have deferred this patch pending acceptance of the bindings
(basically patch 1/2). Please repost this patch or ping me once
that has happened.
