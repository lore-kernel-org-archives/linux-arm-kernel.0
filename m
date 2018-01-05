From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 23:09:04 -0800
Subject: [GIT PULL] TI DaVinci SoC support updates for v4.16
In-Reply-To: <20171223155131.5078-1-nsekhar@ti.com>
References: <20171223155131.5078-1-nsekhar@ti.com>
Message-ID: <20180105070904.ckixnqva6qkbaukc@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 23, 2017 at 09:21:31PM +0530, Sekhar Nori wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.16/soc
> 
> for you to fetch changes up to ed3c0c2b4fdcbe05194ee3f5e634ece3018d3b76:
> 
>   ARM: dts: da850-lcdk: Remove leading 0x and 0s from unit address (2017-12-23 15:46:25 +0530)
> 
> ----------------------------------------------------------------
> DaVinci SoC updates consisting of non-critical bug fixes including constifying
> data structures, DT warning fixes for W=1 and code simplification.
> 
> Also a defconfig update for DaVinci, enabling support for USB network adaptors.

Hi,

We usually don't mix DT and other updates (and sometimes we keep defconfig
updates separate from SoC ones, but that's not needed here).

Can you respin with DT separate? Feel free to just send-email the patch to us,
or send a pull request with it if you prefer.


-Olof
