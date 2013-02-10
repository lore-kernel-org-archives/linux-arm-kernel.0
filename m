From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Feb 2013 20:27:25 -0800
Subject: [GIT PULL] omap multiplatform warning fixes for v3.9 merge window
In-Reply-To: <20130210041949.GG4801@atomide.com>
References: <20130210041949.GG4801@atomide.com>
Message-ID: <CAOesGMjC2NVOuY1D3HK33esJpWa65Nbgj90LoD=6ALcsePeWmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Sat, Feb 9, 2013 at 8:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit ad1bb1b4e01c5ecbe32133ce6921d0e76cb76dcf:
>
>   ARM: OMAP2+: Remove now obsolete uncompress.h and debug-macro.S (2013-01-11 11:24:20 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/multiplatform-fixes-signed-v2

Sorry for the confusion on this; I obviously already had the
hwspinlock patch but I hadn't pushed it out.

So, to make things a little easier I just cherry-picked over the two I
didn't have. Thanks for staging them though. :)


They're all in next/multiplatform now. I'll push out shortly as soon
as my test build completes.


-Olof
