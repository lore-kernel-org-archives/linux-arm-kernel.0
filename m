From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 14:31:44 +0000
Subject: [GIT PULL] adding rpmsg and remoteproc to 3.4
In-Reply-To: <CAK=WgbZ2vfyiR0kXa4+-3y9etxQLBfD8b7QRR+r8VCpbOuBruA@mail.gmail.com>
References: <CAK=WgbZ2vfyiR0kXa4+-3y9etxQLBfD8b7QRR+r8VCpbOuBruA@mail.gmail.com>
Message-ID: <201202231431.44497.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Ohad Ben-Cohen wrote:
> 
> Hi Arnd,
> 
> Please pull:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git rpmsg-for-3.4
> 
> To get the very basic rpmsg+remoteproc core functionality for 3.4.
> 
> This is basically the same stuff I sent for 3.3, with an additional
> fix and cleanup which were reported by Grant (and of course the two
> patches that fixed the 3.3 merge conflicts).
> 
> This entire patch set has been sitting in linux-next for quite some
> time. I'm not sure if it'd conflict with your tree when you pull it,
> but I can of course ask Stephen to remove my tree if things look ok to
> you.

Hi Ohad,

I've looked at the code again now and pulled it into the arm-soc
tree as the next/rpmsg branch, queued for submission to Linus in
the 3.4 merge window. There won't be any conflicts in linux-next
because the commits are identical,  so it doesn't matter whether
you leave your branch in linux-next or now.  If you have updates
on top of this branch, I can apply them directly here.

Let's see how things go after v3.4-rc1  before we decide whether
you want to keep sending patches to arm-soc for v3.5  as well or
whether you just use your own branch then.

	Arnd
