From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Oct 2012 13:42:29 +0000
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <1350448698-26985-1-git-send-email-horms@verge.net.au>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
Message-ID: <201210171342.29635.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 October 2012, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following defconfig enhancements for 3.8.

These look good to me, but I wonder what happened to the plan to reduce
the number of defconfig files we discussed before. Since you can build
a combined kernel that runs on all (or most) of the supported boards,
can you add a combined shmobile_defconfig that is able to work on
a wide variety of hardware and drop some of the less common defconfig
files?

Most of the modern platforms nowadays have just one defconfig that
covers everything.

	Arnd
