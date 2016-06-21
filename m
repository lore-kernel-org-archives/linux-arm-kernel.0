From: horms@verge.net.au (Simon Horman)
Date: Tue, 21 Jun 2016 10:38:37 +0900
Subject: [PATCH v3] arm64: dts: r8a7795: Add CAN FD support
In-Reply-To: <1466166943-17670-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1456906550-4849-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466166943-17670-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <20160621013834.GA18247@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 01:35:43PM +0100, Ramesh Shanmugasundaram wrote:
> Adds CAN FD controller node for r8a7795.
> 
> Note: CAN FD controller register base address specified in R-Car Gen3
> Hardware User Manual v0.5E is incorrect. The correct address is:
> 
> CAN FD - 0xe66c0000
> 
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> 
> Note:
> Bindings already Acked-by: Rob H on driver patch set
> (https://www.mail-archive.com/netdev at vger.kernel.org/msg102789.html)

Thanks, I have queued this up.
