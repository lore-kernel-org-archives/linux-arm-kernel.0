From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:16:06 -0800
Subject: [GIT PULL 1/2] ZTE arm64 device tree changes for 4.11
In-Reply-To: <1485664412-31599-1-git-send-email-shawnguo@kernel.org>
References: <1485664412-31599-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170130051606.GU18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 12:33:31PM +0800, Shawn Guo wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt64-4.11
> 
> for you to fetch changes up to eb2e2a816834cab13311d627844d77bb22bb5787:
> 
>   arm64: dts: zx: support cpu-freq for zx296718 (2017-01-03 15:33:15 +0800)
> 
> ----------------------------------------------------------------
> ZTE arm64 device tree update for 4.11:
>  - Enable cpufreq support for zx296718 by using new operating-points-v2
>    bindings, so that it works with the generic cpufreq-dt driver.
> 
> ----------------------------------------------------------------
> Baoyou Xie (1):
>       arm64: dts: zx: support cpu-freq for zx296718

Merged, thanks.


-Olof
