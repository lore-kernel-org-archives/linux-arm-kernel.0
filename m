From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 14:16:47 -0700
Subject: [GIT PULL 1/3] DaVinci SoC updates for v4.19
In-Reply-To: <20180711062906.22865-1-nsekhar@ti.com>
References: <20180711062906.22865-1-nsekhar@ti.com>
Message-ID: <20180714211647.xzgxoadeckdfd3yf@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 11:59:04AM +0530, Sekhar Nori wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.19/soc
> 
> for you to fetch changes up to 7f69ae7fadd9dbebe563bfc28b993a2bc9c8acf9:
> 
>   ARM: davinci: unduplicate aemif support (2018-07-10 15:39:27 +0530)
> 
> ----------------------------------------------------------------
> DaVinci SoC updates for v4.19
> -----------------------------
> 
> * mach-davinci updates needed to finally move over to common clock framework
> * update to use the aemif driver from drivers/memory rather than the
>   private implementation available in mach-davinci
> 
> For the later item, I have included a branch from David Lechner which
> should also get merged through the clk tree. The clk dependencies are
> needed for aemif conversion.

Thanks, merged.


-Olof
