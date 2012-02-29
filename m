From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 13:14:35 +0000
Subject: [GIT PULL] ux500 patches for v3.4 take 2
In-Reply-To: <CACRpkdbr5X8KLiragbpk0VH5s+uo5T3C+e6AsNHk+x6s80YJ4w@mail.gmail.com>
References: <1330099642-6265-1-git-send-email-linus.walleij@linaro.org>
 <201202270902.29490.arnd@arndb.de>
 <CACRpkdbr5X8KLiragbpk0VH5s+uo5T3C+e6AsNHk+x6s80YJ4w@mail.gmail.com>
Message-ID: <201202291314.36196.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Linus Walleij wrote:
> On Mon, Feb 27, 2012 at 10:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 27 February 2012, Linus Walleij wrote:
> >> On Fri, Feb 24, 2012 at 5:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Friday 24 February 2012, Linus Walleij wrote:
> >> >> are available in the git repository at:
> >> >>   / ..BRANCH.NOT.VERIFIED..
> >> >
> >> > Something wrong on your end apparently.
> >>
> >> Hm :-( I'll check it by pulling it back myself next time.
> >
> > git request-pull checks this already, you just have to make sure that the right
> > branch or tag shows up in the pull URL.
> 
> Hm I think we simply hit "propagated to some mirrors but not all"
> so I saw the branch on my mirror but it wasn't yet up on yours :-/

I'm not convinced we're talking about the same thing here. I'm pretty sure
it was visible on my mirror, but not on yours, hence the
'..BRANCH.NOT.VERIFIED..'.

As I said, git request-pull will look at the remote to figure out which
branch name to put into the text, but it could not find the commit id on
the server when you ran it.
I could of course try to guess which branch you want me to pull, but
I'd rather hear it from you ;-)


	Arnd
