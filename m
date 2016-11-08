From: olof@lixom.net (Olof Johansson)
Date: Tue, 8 Nov 2016 12:22:13 -0800
Subject: [GIT PULL 1/4] DaVinci cleanup for v4.10
In-Reply-To: <20161104062535.9593-1-nsekhar@ti.com>
References: <20161104062535.9593-1-nsekhar@ti.com>
Message-ID: <20161108202213.GH2106@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 11:55:32AM +0530, Sekhar Nori wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/cleanup
> 
> for you to fetch changes up to 766763dbdc1dca11deabdb00077a1c19e2803f0a:
> 
>   ARM: davinci: da8xx: Remove duplicated defines (2016-10-31 16:51:56 +0530)
> 
> ----------------------------------------------------------------
> Clean-up some unnecessary code from mach-davinci.
> 
> - Remove now unneeded dma resources where drivers
>   are already converted to use the dma_slave_map[]
>   structure.
> 
> - Remove some duplicated defines related to USB support.

We don't have a cleanup branch in our tree any more, but thanks for breaking
this out for us anyway! I've merged it into next/soc.


-Olof
