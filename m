From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Oct 2016 22:28:35 -0700
Subject: [GIT PULL 1/4] Broadcom devicetree changes for 4.9 (part 2)
In-Reply-To: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
References: <1475263395-27653-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20161003052835.GC5655@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 12:23:12PM -0700, Florian Fainelli wrote:
> The following changes since commit 7260ecd22baa3c62ef6efaf59e7de53f4c8df800:
> 
>   Merge tag 'bcm2835-dt-next-2016-08-29' into devicetree/next (2016-08-30 20:02:04 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.9/devicetree-part2
> 
> for you to fetch changes up to ef3bc318adeb15b38688df6a583bafea2befce43:
> 
>   ARM: BCM5301X: Add DT for Luxul XWR-3100 (2016-09-30 11:58:31 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree changes for 4.9,
> please pull the following:
> 
> - Rafal adds support for the Netgear R8500 routers, adds basic support
>   for the Tenda AC9 router which uses the new BCM53573 SoC (single core Cortex
>   A7). He also enables the UART on the Netgear R8000 and restructures the
>   include files a bit for the BCM47094 SoC, finally he adds USB 3.0 PHY nodes
>   which enables USB 3.0 on BCM5301X devices that support it
> 
> - Kamal adds support for the QSPI controller on the Northstar Plus SoCs and updates
>   the bcm958625k reference board to have it enabled
> 
> - Dan adds support for the Luxul XAP-1510 and XWR-3100 devices

Hi Florian,

Given the timing of these pull requests, we'll have to hold them off
for 4.10. The defconfig changes can be considered for -rc2, but the
DT contents should wait.

Please send a fresh pull request once 4.9-rc1 is out.



Thanks,


-Olof
