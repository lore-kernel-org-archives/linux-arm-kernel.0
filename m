From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:25:19 +0900
Subject: [PATCH 04/05] ARM: shmobile: Let KZM9D multiplatform boot with
 KZM9D DTB
In-Reply-To: <20131001103334.813.45590.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103334.813.45590.sendpatchset@w520>
Message-ID: <20131003042517.GP7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 07:33:34PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Let the multiplatform KZM9D support boot with the
> legacy DTS for KZM9D as well as the KZM9D reference DTS.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
