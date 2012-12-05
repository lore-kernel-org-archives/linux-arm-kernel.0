From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Dec 2012 15:58:48 -0500
Subject: [GIT PULL] Improve the SMP support of the interrupt controller
 for Armada XP
In-Reply-To: <50BFB23C.5040906@free-electrons.com>
References: <1354714394-11622-1-git-send-email-gregory.clement@free-electrons.com>
 <50BFAE8B.1080303@free-electrons.com>
 <20121205203607.GW12509@titan.lakedaemon.net>
 <50BFB23C.5040906@free-electrons.com>
Message-ID: <20121205205848.GX12509@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 09:44:44PM +0100, Gregory CLEMENT wrote:
> On 12/05/2012 09:36 PM, Jason Cooper wrote:
> > On Wed, Dec 05, 2012 at 09:28:59PM +0100, Gregory CLEMENT wrote:
> >> On 12/05/2012 02:33 PM, Gregory CLEMENT wrote:
> >>> Jason,
> >>>
> >>> here it is the patch set to improve the Armada XP SMP support. This
> >>> pull can be merged without any conflict even on the last
> >>> arm-soc/for-next. As Linus Torvalds told that the release of 3.7 won't
> >>> happen before next week, I'd like to have this improvement as part of
> >>> 3.8.
> >>>
> >>
> >> Please ignore this git pull, the code is buggy in non-SMP mode. A new
> >> version is incoming. Sorry.
> > 
> > Ok, please do me a favor and don't send pull requests until patches have
> > had sufficient review on lakml.
> > 
> 
> OK, I will

Just to be clear, I don't mind if you throw it up on your public repo
and put the git pull info in a cover letter or the remarks section of
patch email.  The problem is when folks see 'GIT PULL' in the subject,
they assume it has already been reviewed.  And, thus, don't review it.

hth,

Jason.
