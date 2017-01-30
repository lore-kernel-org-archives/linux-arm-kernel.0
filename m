From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:04:53 -0800
Subject: [GIT PULL 2/4] TI DaVinci SoC support updates for v4.11
In-Reply-To: <20170124130641.28264-2-nsekhar@ti.com>
References: <20170124130641.28264-1-nsekhar@ti.com>
 <20170124130641.28264-2-nsekhar@ti.com>
Message-ID: <20170130010453.GR3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 06:36:39PM +0530, Sekhar Nori wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/soc
> 
> for you to fetch changes up to 9c9b1bc25291e275b04f758f2549c81e092954f5:
> 
>   ARM: davinci: add skeleton for pdata-quirks (2017-01-23 20:52:38 +0530)
> 
> ----------------------------------------------------------------
> Introduce pdata-quirks mechanism for
> DaVinci which will be needed for supporting
> video input/output on DA850 SoC.
> 
> ----------------------------------------------------------------
> Kevin Hilman (1):
>       ARM: davinci: add skeleton for pdata-quirks

I'm not much of a fan of adding this. I know we added it for some of
the legacy platforms since moving over existing in-tree code would take
a while. But the thought was that new drivers wouldn't use it much.

Is the need for this now due to said drivers never been ported over, and now
also being used by Davinci? Or are new drivers added that rely on platform
data?


-Olof
