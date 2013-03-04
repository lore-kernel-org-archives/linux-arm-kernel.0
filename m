From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Mar 2013 21:14:48 +0000
Subject: [GIT PULL 0/3] arm-soc: late changes for 3.9
In-Reply-To: <CA+55aFx2Cuuq2YW6mexxZ88TNm=FLYUYPzeLqN=y46oYxZJ3wQ@mail.gmail.com>
References: <1362092093-4839-1-git-send-email-olof@lixom.net>
 <CA+55aFx2Cuuq2YW6mexxZ88TNm=FLYUYPzeLqN=y46oYxZJ3wQ@mail.gmail.com>
Message-ID: <201303042114.49096.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 March 2013, Linus Torvalds wrote:
> On Thu, Feb 28, 2013 at 2:54 PM, Olof Johansson <olof@lixom.net> wrote:
> >
> > Final two pull requests are for the same code. As Arnd describes in the
> > tags, they are for a set of mvebu patches that depend on contents in
> > the MMC tree. We had pulled in part of the MMC branch as a dependency,
> > but unfortunately Chris Ball rebased it.
> 
> Has Chris Ball been told what an incredible pain this kind of crap is,
> and that there's a damn good reason why WE DO NOT REBASE PUBLIC TREES
> THAT OTHERS MAY BE BASING THEIR DEVELOPMENT ON!
> 
> Chris, can you hear me shouting? Don't do that.

I talked to Chris while I prepared the two branches, and he now understands
the consequences and won't do it again.

I also talked to Jason Cooper about it and he is going to do his branches
differently now to avoid building deep dependency chains on other trees.
We've had similar problems with other subsystem maintainers before, but
there are a lot more subsystems that one can depend on. We generally
try to do the branches in a way that we can drop a small part of the stuff
in arm-soc without rebasing when someone else screws up, but that did not
happen in this case.

	Arnd
