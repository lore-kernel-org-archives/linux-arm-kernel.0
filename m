From: horms@verge.net.au (Simon Horman)
Date: Tue, 16 Apr 2013 11:35:22 +0900
Subject: [PATCH] arm: shmobile: armadillo800eva: Fix maximum number of SCIF
In-Reply-To: <1366001092-8753-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1366001092-8753-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <20130416023522.GA28660@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 01:44:52PM +0900, Nobuhiro Iwamatsu wrote:
> The r8a77740 has 9ch SCIF. It is not 8ch.

Thanks, queued up for v3.11 in the defconfig-armadillo800eva branch.
I plan to push that branch later today.
