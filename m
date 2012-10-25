From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 13:44:44 +0000
Subject: [GIT PULL] first set of ux500 for ARM SoC for v3.8
In-Reply-To: <CACRpkdbSx-e4q+++=chjgyt0yD_v=JOP5OrQPoXb2-EPfNnrvg@mail.gmail.com>
References: <CACRpkdasaP_xVfQtzq29UNJBXetrUUzqpn90T6_Gr0kOsV8GeQ@mail.gmail.com>
 <CACRpkdbSx-e4q+++=chjgyt0yD_v=JOP5OrQPoXb2-EPfNnrvg@mail.gmail.com>
Message-ID: <201210251344.44546.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012, Linus Walleij wrote:
> On Thu, Oct 18, 2012 at 8:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > Hi ARM SoC folks,
> >
> > here are two small commits for v3.8 that I'd like to make sure
> > land in ARM SoC before I begin with all the other stuff.
> >
> > Please pull them in!
> 
> Ping on this.

Sorry for the delay, I just took over the task to pull in stuff from Olof
and we were both busy otherwise earlier.

I pulled this into a next/soc branch now. Wasn't completely sure which
branch to use but I figured that we couldn't make a good prediction of
the ordering yet, and we'll probably have a next/soc2 branch later anyway.

Please remember to write the pull request in a way that lets us reuse some
of the text for the merge changeset comment. Ideally in a signed tag
so git puts it in there automatically.

	Arnd
