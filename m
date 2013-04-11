From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 19:29:30 -0400
Subject: [PATCH v3 4/9] ARM: mvebu: Enable pj4b on LPAE compilations
In-Reply-To: <51671FFE.1010909@free-electrons.com>
References: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
 <1365461538-30702-5-git-send-email-gregory.clement@free-electrons.com>
 <20130411180844.GO28693@titan.lakedaemon.net>
 <51671FFE.1010909@free-electrons.com>
Message-ID: <20130411232930.GQ28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 10:41:34PM +0200, Gregory CLEMENT wrote:
> Hi Jason,
> 
> On 04/11/2013 08:08 PM, Jason Cooper wrote:
> > On Tue, Apr 09, 2013 at 12:52:12AM +0200, Gregory CLEMENT wrote:
> >> From: Lior Amsalem <alior@marvell.com>
> >>
> >> pj4b cpus are LPAE capable so enable them on LPAE compilations
> >>
> >> Signed-off-by: Lior Amsalem <alior@marvell.com>
> >> Tested-by: Franklin <flin@marvell.com>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >>  arch/arm/mm/proc-v7.S |    3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Applied to mvebu/soc
> > 
...
> 
> However, this one should go through Russell's git tree.  Or at least
> you need his acked-by. I have already submit this patch on Russell
> patch system. Unfortunately Russell told that he will be away for
> around one week.
> 
> This patch is needed to have LPAE support, but all the other patches
> don't depend on it. That means that if you applied all the other
> patches it won't break anything even if at the end this patch is not
> merged. But I really hope that Russell will be able to apply this
> patch to his git tree.

ok, thanks for catching this before I sent the PR.  I'll drop it.

thx,

Jason.
