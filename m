From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 14:55:58 -0700
Subject: [GIT PULL] berlin dt64 changes for v4.18
In-Reply-To: <20180524160420.35da91b5@xhacker.debian>
References: <20180524160420.35da91b5@xhacker.debian>
Message-ID: <20180525215558.yc5anyapi2xcq4ir@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 04:04:20PM +0800, Jisheng Zhang wrote:
> Hi,
> 
> Here is the pull request for berlin dt64 changes for v4.18.
> 
> Thanks,
> Jisheng
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin64-dt-for-v4.18
> 
> for you to fetch changes up to 031106ce95a201f6dd4c5ebf35abb900cf34e2ba:
> 
>   arm64: dts: move berlin SoC files from marvell dir to synaptics dir (2018-05-24 13:25:45 +0800)
> 
> ----------------------------------------------------------------
> Berlin64 DT changes for v4.18
> 
>  - use SPDX-License-Identifier for dts(i) files
>  - move berlin SoC dts(i) files from marvell dir to synaptics dir

Usually we don't do renames, but this is a pure file move so it's not causing
significant disturbance, and there seems to be quite little overlap between
this and other marvell platforms on includes, etc, so it seems ok.


Merged, thanks!


-Olof
