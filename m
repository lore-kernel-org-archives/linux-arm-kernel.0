From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 4 Mar 2012 21:27:52 +0000
Subject: [GIT PULL 0/6] Tegra branches for 3.4
In-Reply-To: <1330892042-32065-1-git-send-email-olof@lixom.net>
References: <1330892042-32065-1-git-send-email-olof@lixom.net>
Message-ID: <201203042127.53017.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 March 2012, Olof Johansson wrote:
> Hi Arnd,
> 
> Below are the 6 pull requests for Tegra platforms for 3.4. This is also
> likely my last merge request for tegra material (besides possibly some
> stray patches between now and the merge window), since I am handing off
> main maintainership to Stephen Warren for the next merge window.
> 
> Each branch is documented in the tag (they are all tag pull requests), as
> well as in the emails below. Nothing too controversial.
> 
> There are a handful of trivial merge conflicts between the branches,
> mostly to the Makefile due to context chances. I also had a local
> issue where git auto-resolved the merge of the T30 SMP branch into
> my for-next branch, and did NOT remove the mach/system.h include at
> arch/arm/mach-tegra/common.c. This results in a build break since it
> has been removed in rmk/for-armsoc. So just a heads up in case you see
> the same thing.

Hi Olof,

I've pulled them all into the respective branches. I'll send out a
status of all the stuff (and missing stuff) in arm-soc.git tomorrow
and then hand back over to you for a while until you need to shift
your own focus again.

	Arnd
