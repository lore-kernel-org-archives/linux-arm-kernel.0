From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 12:45:10 +0900
Subject: [PATCH 06/10] ARM: shmobile: r8a7791 Arch timer workaround
In-Reply-To: <20131001081248.4136.41380.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081248.4136.41380.sendpatchset@w520>
Message-ID: <20131003034506.GE28463@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:12:48PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Make use of the R-Car Gen2 arch timer workaround on r8a7791.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>


Thanks, I have queued this up in the soc3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The soc3 branch includes soc code previously queued up for v3.13
and a merge with renesas-smp-for-v3.13 which I sent a pull request for
a few days ago. The reason for the merge is to reduce conflicts.
