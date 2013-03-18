From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 15:54:55 +0000
Subject: [GIT PULL] arm-soc fixes for v3.9-rc3
In-Reply-To: <CA+55aFx9NF-+dt5r_hOpUfZxd6Ky+OBL2echeeM50ZE6UAaAdA@mail.gmail.com>
References: <201303181422.14942.arnd@arndb.de>
 <CA+55aFx9NF-+dt5r_hOpUfZxd6Ky+OBL2echeeM50ZE6UAaAdA@mail.gmail.com>
Message-ID: <201303181554.55853.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Linus Torvalds wrote:
> On Mon, Mar 18, 2013 at 7:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > are available in the git repository at:
> >
> >   git+ssh://gitolite at ra.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes
> 
> What the heck happened to your script?
> 
> Please use the public address so that others could look at it if they
> want to (and so that my merge messages make sense in a public
> setting).
> 
> I fixed it up, but please fix your script for next time.

Thanks for fixing it up, it was no script this time, but a manual copy-paste
mistake. git-request-pull got confused by the fact I had commits both before
and after -rc2 in the branch, and was listing lots of changes that you had
already merged in the list, so I tried to construct the output in the
way that was supposed to look, and failed.

	Arnd
