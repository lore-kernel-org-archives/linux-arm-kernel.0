From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Aug 2011 09:32:52 +0100
Subject: Fwd: [GIT PULL] [3.2] Please pull tegra boards for 3.2
In-Reply-To: <CAOesGMj5P9yLO0My4UB7AEj+9NdmYq8HYwVMd3Uv1NQO6+WP7A@mail.gmail.com>
References: <CAOesGMjHN-pvVfMN0o3AD238m8wEiRS-D4ArjV_2VAGTuwPfBw@mail.gmail.com>
	<201108161648.58250.arnd@arndb.de>
	<CAOesGMgZCFF=dWhAm_+Ux-c-aORqo4sJ1DOGirCu3QT-iMcQRQ@mail.gmail.com>
	<2300535.b0zjAbUTLi@wuerfel>
	<CAOesGMj5P9yLO0My4UB7AEj+9NdmYq8HYwVMd3Uv1NQO6+WP7A@mail.gmail.com>
Message-ID: <20110826083252.GE11250@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 10:23:21PM -0700, Olof Johansson wrote:
> Ok. Sounds like there might be some use for a temporary "work in
> progress" branch for linux-next for patches that are nearly ready to
> go but not quite that needs air time, but not really for anything
> beyond that.

Bad idea.

linux-next's policy is that everything in linux-next should be ready
for mainline - not nearly ready.

Linus is threatening at the next merge window to ignore pull requests
from maintainers, and just pull the entire linux-next tree into his at
the beginning.  Anything in linux-next which is "work in progress" will
therefore find its way immediately into mainline in whatever state it's
in.

So, everyone needs to ensure that linux-next only contains code that's
100% ready for merging during the next merge window.  Everything else
should not be in linux-next.
