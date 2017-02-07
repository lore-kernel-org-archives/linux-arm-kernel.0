From: horms@verge.net.au (Simon Horman)
Date: Tue, 7 Feb 2017 12:21:43 +0100
Subject: [PATCH 0/5] arm64: dts: r8a779[56]: EtherAVB Gigabit timing
 enhancements
In-Reply-To: <1485938524-9322-1-git-send-email-horms+renesas@verge.net.au>
References: <1485938524-9322-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20170207112143.GA28188@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 09:41:59AM +0100, Simon Horman wrote:
> Hi,
> 
> this series tweaks PHY settings to address communications failures reported
> for 1Gbit communication using EtherAVB. Gigabit is supported for R-Car H3
> ES1.1+ and M3-W as of commit 0e98f9d5f0b4 ("ravb: Support 1Gbps on R-Car H3
> ES1.1+ and R-Car M3-W") which is present in net-next and should be included
> in v4.11.
> 
> This series is based on renesas-devel-20170130-v4.10-rc6

I have queued up this series for v4.12.
