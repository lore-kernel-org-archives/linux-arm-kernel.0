From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Jan 2014 13:28:06 -0500
Subject: [PATCH V2 1/2] ARM: multi_v7_defconfig: update for v3.13-rc1
In-Reply-To: <CAOesGMh3qho=-3sN2-ju_-npggLSvD-s4Mnwt0EyVVh+YT7jYA@mail.gmail.com>
References: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
 <14397edee7978df1d80e048d7cd02c826a91af56.1390932990.git.jason@lakedaemon.net>
 <CAOesGMh3qho=-3sN2-ju_-npggLSvD-s4Mnwt0EyVVh+YT7jYA@mail.gmail.com>
Message-ID: <20140128182806.GW29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:22:31AM -0800, Olof Johansson wrote:
> On Tue, Jan 28, 2014 at 10:20 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Just the output of:
> >
> >   make ARCH=arm multi_v7_defconfig
> >   make savedefconfig
> >   mv defconfig arch/arm/configs/multi_v7_defconfig
> >
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> 
> Do you mean 3.14-rc1? If so, this will likely have conflicts with the
> multi_v7_defconfig that we still have in our for-next branch (should
> be queued in a regular branch now that all the contents has been
> merged in by Linus).

No, I meant v3.13-rc1.  mvebu/defconfig branch is still based on
v3.13-rc1 since there is no stable tag for v3.14 yet.

Let me know how you'd like me to handle it.  My main goal is to have
something locally I can build and test against as well.  If you think
you can get this in in time for v3.14-rc1, I'll rebase this series
against arm-soc/for-next and then base all my branches off of v3.14-rc1
when it drops.

thx,

Jason.
