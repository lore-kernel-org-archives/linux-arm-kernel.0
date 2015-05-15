From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 17:33:52 +0200
Subject: [GIT PULL] ARM: berlin: DT changes for v4.2 (round 1)
In-Reply-To: <1431687246-31039-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431687246-31039-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1431687246-31039-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <2418982.DaY2mGZ7YN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 May 2015 12:54:06 Sebastian Hesselbarth wrote:
> this is Marvell Berlin SoC DT for v4.2 including:
> - GPLv2/X11 dual-licensing of DT files,
> - a note about currently unstable DT bindings as we struggle to get
>   DT bindings right in the first place with limited documentation available,
> - Rework of System/Chip Controller binding documentation and nodes to
>   simple-mfd.
> 

I'm a bit confused by this. Are you sure that it's ok to apply this branch
by itself without introducing regressions or bisection problems?

It's fine to have unstable bindings for a while as you are ramping up,
but that requires a lot more care on your side regarding the order in
which you send the patches. I have received three pull requests from
you that are all based on -rc1, and from a brief look it seems like
they are interdependent, which would not be ok.

	Arnd
