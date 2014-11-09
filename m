From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Nov 2014 16:48:50 -0800
Subject: [GIT PULL 3/3] ARM: berlin: DT changes for v3.19 (round 1)
In-Reply-To: <1414927473-25249-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1414927473-25249-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1414927473-25249-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20141109004850.GA13776@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 02, 2014 at 12:24:33PM +0100, Sebastian Hesselbarth wrote:
> Arnd, Kevin, Olof,
> 
> this is Berlin DT changes for v3.19 and contains those patches that missed
> the v3.18 merge window plus corresponding patches to catch-up with Antoine's
> BG2Q improvements for BG2 and BG2CD. We now have working SDHCI and Ethernet
> on all SoCs (well, BG2CD has HDMI HEC only), SATA PHY support for BG2 is still
> pending.
> 
> Please pull.
> 
> Thanks,
>   Sebastian
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-3.19-1
> 
> for you to fetch changes up to e4fdc8e5821d852a933963ba56b9b2fa8f68c68f:
> 
>   ARM: dts: berlin: Enable eMMC on Sony NSZ-GS7 (2014-10-29 19:44:47 +0100)
> 
> ----------------------------------------------------------------
> Berlin DT changes for v3.19 (round 1)
> - AHCI and SATA PHY nodes for BG2Q
> - Reset controller binding docs
> - Ethernet nodes for BG2, BG2CD
> - SDHCI nodes for BG2, BG2CD
> - Corresponding board changes to enable AHCI, Ethernet, SDHCI

Merged, thanks.


-Olof
