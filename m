From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:56:59 -0700
Subject: [GIT PULL 5/6] Freescale arm64 device tree updates for 4.19
In-Reply-To: <1532140671-2869-2-git-send-email-shawnguo@kernel.org>
References: <1532140344-2771-1-git-send-email-shawnguo@kernel.org>
 <1532140671-2869-1-git-send-email-shawnguo@kernel.org>
 <1532140671-2869-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20180721215659.uvg3vhmsxxcsrj6f@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 10:37:50AM +0800, Shawn Guo wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.19
> 
> for you to fetch changes up to 346f5976cc3200896d5fb873412a4fe9c0fc611e:
> 
>   arm64: dts: freescale: Add missing cooling device properties for CPUs (2018-07-03 15:01:09 +0800)
> 
> ----------------------------------------------------------------
> Freescale arm64 device tree update for 4.19:
>  - Update device tree sources to use SPDX identifiers for license.
>  - Add cooling device property '#cooling-cells' for all CPUs of
>    a cluster.
> 
> ----------------------------------------------------------------
> Li Yang (1):
>       arm64: dts: freescale: Update to use SPDX identifiers
> 
> Viresh Kumar (1):
>       arm64: dts: freescale: Add missing cooling device properties for CPUs

Merged, thanks.


-Olof
