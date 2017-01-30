From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 16:58:28 -0800
Subject: [GIT PULL 1/4] TI DaVinci non-critical fixes for v4.11
In-Reply-To: <20170124130641.28264-1-nsekhar@ti.com>
References: <20170124130641.28264-1-nsekhar@ti.com>
Message-ID: <20170130005828.GQ3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 06:36:38PM +0530, Sekhar Nori wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/fixes-non-critical
> 
> for you to fetch changes up to 430d7dd448f48f54e79614ca237f44cd543f73da:
> 
>   bus: da850-mstpri: fix my e-mail address (2017-01-02 15:52:32 +0530)
> 
> ----------------------------------------------------------------
> Non-critical DaVinci fixes for v4.11
> 
> * Coding style and typo fix
> * Make PLL0 rate setting API for DA850
>   less confusing to use.
> 
> ----------------------------------------------------------------
> Bartosz Golaszewski (3):
>       ARM: davinci: da850: coding style fix
>       ARM: davinci: da850: fix da850_set_pll0rate()
>       bus: da850-mstpri: fix my e-mail address

Merged, thanks.


-Olof
