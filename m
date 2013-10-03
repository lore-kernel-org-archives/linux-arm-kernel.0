From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 12:46:13 +0900
Subject: [PATCH 08/10] ARM: shmobile: r8a7791 SMP device tree node
In-Reply-To: <20131001081307.4136.88788.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081307.4136.88788.sendpatchset@w520>
Message-ID: <20131003034612.GF28463@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:13:07PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add a device node for the r8a7791 secondary CPU core.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r8a7791.dtsi |    7 +++++++
>  1 file changed, 7 insertions(+)

Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The dt3 branch is a merge of other dt changes queued up for v3.13
with renesas-soc-for-v3.13, which I sent a pull request for a few
days ago. The reason for the merge is to provide the dts for the
r8a7791 SoC which is changed by patches this patch.

It might have been better to merge the dt for the r8a7791 SoC 
in a separate patch in the dt branch. But it wasn't.
