From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Feb 2013 15:24:26 +0000
Subject: [GIT PULL 2/4] ARM broadcast timer updates for 3.9
In-Reply-To: <1359986131-13034-2-git-send-email-will.deacon@arm.com>
References: <1359986131-13034-1-git-send-email-will.deacon@arm.com>
 <1359986131-13034-2-git-send-email-will.deacon@arm.com>
Message-ID: <20130204152426.GG17786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 01:55:29PM +0000, Will Deacon wrote:
> Hello again,
> 
> This is the second part of the kvm-related series and moves ARM over to
> the generic timer broadcast implementation, currently queued by tglx in
> -tip.
> 
> Please note that, due to this dependency, this branch contains mainline
> up to ~-rc6, so you may want to keep it on a separate branch to avoid
> pulling in a bunch of unrelated changes from -tip.

Both 1 and 2 pulled and merged.  I'll wait 24 hours before pushing this out
so that the nightly build can have a go at it before the new devel-stable
branch gets published.
