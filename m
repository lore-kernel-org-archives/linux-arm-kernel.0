From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:26:09 +0900
Subject: [PATCH 05/05] ARM: shmobile: Remove KDM9D reference DTS
In-Reply-To: <20131001103343.813.54921.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103343.813.54921.sendpatchset@w520>
Message-ID: <20131003042608.GQ7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 07:33:43PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Now when the legacy DTS file emev2-kzm9d.dts can be
> used with board-kzm9d.c and board-kzm9d-reference.c
> proceed with removing emev-kzm9d-reference.dts.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.
