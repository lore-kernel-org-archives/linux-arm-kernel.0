From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Jan 2018 17:36:02 -0800
Subject: [GIT PULL] TI DaVinci SoC updates for v4.16 (part 2)
In-Reply-To: <20180110112505.13633-1-nsekhar@ti.com>
References: <20180110112505.13633-1-nsekhar@ti.com>
Message-ID: <20180112013602.q2sm25s6o3oebkbj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 04:55:05PM +0530, Sekhar Nori wrote:
> The following changes since commit 23bbeaef90ab7607d03428bbb708efe44f43c761:
> 
>   ARM: davinci: constify gpio_led (2018-01-05 19:28:41 +0530)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.16/soc-p2
> 
> for you to fetch changes up to 0808d3260456aaba061fe06ead31d578c8bdc936:
> 
>   ARM: davinci: remove watchdog reset (2018-01-10 14:38:07 +0530)
> 
> ----------------------------------------------------------------
> A patch to shift to using watchdog timer for DaVinci restart functionality.
> The driver support is present in linux-next as 71d1f058844d "watchdog:
> davinci_wdt: add restart function"

Hi,

So if this is merged before the driver is merged, what happens? Might
be better to hold off a release to avoid regressions?


-Olof
