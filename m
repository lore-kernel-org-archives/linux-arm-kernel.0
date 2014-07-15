From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jul 2014 17:17:34 +0200
Subject: [GIT PULL] Mediatek basic support for v3.17
In-Reply-To: <20140715135913.GA18571@kroah.com>
References: <CABuKBe+h0Et5_+o4_i-Eu7EQ8Xka7YFoKmO=U0B7NnVQBdQ8FA@mail.gmail.com>
 <20140715135913.GA18571@kroah.com>
Message-ID: <14060966.Jhk08lR3XI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 July 2014 06:59:13 Greg KH wrote:
> On Tue, Jul 15, 2014 at 01:11:42PM +0200, Matthias Brugger wrote:
> > The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> > 
> >   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/mbgg/linux-mediatek.git tags/v3.17-next-basic-support
> 
> As these are only 7 patches, why do a git pull?  And I know I can't take
> pull requests from github, I'm not sure what the rules are for the ARM
> SoC developers either...
> 
> Just send patches, it's easier that way.

We generally prefer pull requests, but patches also work for us.

However, one note about the text in the pull request: Matthias,
please always try to be explicit about who you want to pull or
merge things when you are ready and list in the pull request the
other maintainers that have agreed to merging it (or whether they
have not sent an Ack yet, which is even more important).

In this case, the clocksource driver needs an Ack from the clocksource
maintainers, and the drivers/of/address.c changes need an Ack from the
OF maintainers. I assume you have those, but I'd have to first look
at the patches to be sure.

	arnd
