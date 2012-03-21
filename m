From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Mar 2012 18:26:38 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203211404.35847.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <CAOh2x==J4qkp29w+v=GWORBua-DE3yb0MRGOtBLyELxbGZwcuA@mail.gmail.com>
 <201203211404.35847.arnd@arndb.de>
Message-ID: <201203211826.38993.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 March 2012, Arnd Bergmann wrote:
> 
> On Wednesday 21 March 2012, viresh kumar wrote:
> > On Wed, Mar 21, 2012 at 6:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Just let me know how you want to handle
> > > these things in the future -- the normal way would be to always let you
> > > forward the patches to me, rather than having them applied to arm-soc
> > > directly.
> > 
> > Hmmm. I don't know how exactly it works, but maybe you can add me as
> > an custodian for SPEAr, with a git repo somewhere in kernel.org (?).
> > So that i can apply patches directly to my branch, you pull it.
> > What do you say?
> 
> Yes, that would be the ideal way. You are already listed in the MAINTAINERS
> file, so nothing would change in theory. If you don't have an account on
> kernel.org yet, see http://www.kernel.org/faq/#account for how to get
> one. This will require that you have your gpg keys signed by at least
> one person in the kernel web of trust, so you may have to find people
> locally who can sign yours and are already signed.

I just noticed that you have git trees on http://git.stlinux.com/,
which I would personally prefer you to use actually. git.kernel.org
is most useful for people that don't have their own git servers.

	Arnd
