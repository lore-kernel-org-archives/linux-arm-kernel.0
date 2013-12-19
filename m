From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 19 Dec 2013 10:25:36 -0800
Subject: [GIT PULL v2] ARM: Initial support for Marvell Berlin SoCs
In-Reply-To: <1387357681-30730-1-git-send-email-sebastian.hesselbarth@gmail.com>
 (Sebastian Hesselbarth's message of "Wed, 18 Dec 2013 10:08:01 +0100")
References: <1387202444-7270-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1387357681-30730-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <87pposk89r.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

> Dear ARM maintainers,
>
> please pull the initial support patches for Marvell Berlin SoCs.
> While this is the initial PR, it is not yet split up into the
> usual sub-branches. If you require it, please request it.

In the future, please split things up into the usual branches.  However,
for new SoC support like this, where it's new files being added, the
risk of conflicts is low so I'm OK keeping it all together.

In particular, normally the drivers/* stuff should go through the
driver/subsystem maintainer, but I see that tglx reviewed this one so
I'm assuming that means he's OK with it going through our tree along
with the DT binding.

> Compared to the last patch set sent on list, the branch below:
> - does not contain Tauros3 patch which has been submitted to
>   rmk's patch system separately.
> - went back to soc-board.dts[i] naming as mentioned by Olof.
>
> Thanks to Jason Cooper, this PR now uses a signed tag.

Excellent, thanks!

> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   https://github.com/shesselba/linux-berlin.git tags/berlin-3.14
>
> for you to fetch changes up to 1c37fa10b275d3e5b6285066b5b27c8feae688c8:
>
>   ARM: add initial support for Marvell Berlin SoCs (2013-12-13 16:31:07 +0100)
>
> ----------------------------------------------------------------
> Initial support for Marvell Berlin SoCs, e.g. Armada 1500 and
> Armada 1500-mini, found on various consumer devices like Google Chromecast
> and GoogleTV.
>
> ----------------------------------------------------------------

Looks like it's finally time to pry open the Chromecast and build myself
a serial cable. :)

Pulled into next/soc.

Thanks,

Kevin
