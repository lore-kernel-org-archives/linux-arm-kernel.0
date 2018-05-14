From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 00:59:52 -0700
Subject: [GIT PULL] DaVinci fixes for v4.17
In-Reply-To: <8a5aef77-d983-03a4-6387-31f4e6fd0bb7@ti.com>
References: <8a5aef77-d983-03a4-6387-31f4e6fd0bb7@ti.com>
Message-ID: <20180514075952.jfocktvpgj7nhgrf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 08:24:54PM +0530, Sekhar Nori wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.17
> 
> for you to fetch changes up to 9411ac07cd764be34bbd7ff09125a6b7b9175d4c:
> 
>   ARM: davinci: fix GPIO lookup for I2C (2018-05-02 14:55:06 +0530)
> 
> ----------------------------------------------------------------
> DaVinci fixes for v4.17
> * W=1 warning fixes in device-tree files
> * GPIO look-up fixes for legacy boot on several platforms

The warning fixes might be a bit late at this point, but this has been
sitting there for a while so I can't really ask you to respin without them.

Merged as-is. Thanks!


-Olof
