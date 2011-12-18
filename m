From: olof@lixom.net (Olof Johansson)
Date: Sat, 17 Dec 2011 20:48:31 -0800
Subject: [PATCH v7 00/14] Add support for tegra30 and cardhu
In-Reply-To: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323875032-18221-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111218044831.GB4336@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 05:03:12PM +0200, Peter De Schrijver wrote:
> This patchset adds support for the tegra30 SoC and the cardhu development
> board.

Thanks, applied to for-3.3/dt (first patch) and for-3.3/soc (the rest).
I didn't want to split up too much between the branches and make
cross-dependencies since that defeats most of the idea behind topic branches,
so I left it at that.

I rebased for-3.3/soc (which only had one patch on it before) to be on top of
rmk's devel-stable and for-3.3/dt, and will tell Arnd about those dependencies
when sending up the branches -- other SoCs have similar dependencies already so
it's not a problem.

I had to do some minor touchups, including redoing the move of board-dt.c due
to other changes to the file. Please check final contents of the branch and let
me know if there's a problem.

Also, the defconfig needs to be updated to enable t30 support as well as move
over to the new config option for t20. I'll post a patch in a few minutes.

Please let me know how the branch looks as soon as practical, since the
clock is ticking on getting the branches into arm-soc in the next few
days for the upcoming merge window.


-Olof
