From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Mar 2017 17:57:35 +0100
Subject: [GIT PULL 2/2] Broadcom arm64 Device Tree fixes for 4.11
In-Reply-To: <20170322180300.27599-2-f.fainelli@gmail.com>
References: <20170322180300.27599-1-f.fainelli@gmail.com>
 <20170322180300.27599-2-f.fainelli@gmail.com>
Message-ID: <CAK8P3a1TV=Hq0EHKCRZgc14dYYxcUFMrxj=CM-sdPhhpF=GXfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 7:03 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   http://github.com/Broadcom/stblinux tags/arm-soc/for-4.11/devicetree-arm64-fixes
>
> for you to fetch changes up to f0c0cb99f74c03e2407ea553f6d46eb611e262b5:
>
>   arm64: dts: NS2: Add dma-coherent to relevant DT entries (2017-03-22 10:14:14 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM64-based SoCs Device Tree fixes for 4.11,
> please pull the following:
>
> - Jon adds missing "dma-coherent" property to the Northstar 2 DTS include file
>   in order to fix both performance and cache problems for: PCIe, Ethernet,
>   PDC/mailbox, SATA3 and SDHCI

Pulled into fixes, thanks!

      Arnd
