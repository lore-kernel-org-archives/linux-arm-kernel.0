From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Jan 2013 15:04:51 +0900
Subject: [PATCH 0/8] ARM: shmobile: pinctrl and DT extensions
In-Reply-To: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130117060451.GD1197@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 06:08:09PM +0100, Guennadi Liakhovetski wrote:
> These patches extend sh7372 and r8a7740 pinctrl support and use it to add 
> SDHI and MMCIF to armadillo800eva and mackerel reference DT 
> implementations. GPIO-based pin configuration is removed from board files. 
> Additionally, MMC interfaces on armadillo800eva support run-time 
> power-switching, which is also supported in DT with these patches.
> 
> This series is based on recent work by Laurent and Simon. sh7372 and 
> r8a7740 pinctrl support seems to be stable and, probably, won't change, 
> so, also the base for these patches seems solid. Since the current pinctrl 
> implementation for sh73a0 is likely to change, support for kzm9g isn't 
> included in this series.

Thanks.

As these depend on at least one outstanding series from Laurent,
I'm going to wait for some fresh patches from him before applying this.
