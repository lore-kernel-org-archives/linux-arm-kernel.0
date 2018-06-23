From: olof@lixom.net (Olof Johansson)
Date: Sat, 23 Jun 2018 10:20:03 -0700
Subject: [GIT PULL 1/3] Broadcom devicetree fixes for 4.18
In-Reply-To: <20180619233104.32173-1-f.fainelli@gmail.com>
References: <20180619233104.32173-1-f.fainelli@gmail.com>
Message-ID: <CAOesGMjVK8tjndxdEWM1cCLb4ev7ur7Q-eDM8NM=S9pKAkRm4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 4:31 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>
> are available in the git repository at:
>
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.18/devicetree-fixes
>
> for you to fetch changes up to 6cb1628ad3506b315cdddd7676db0ff2af378d28:
>
>   ARM: dts: Cygnus: Fix PCIe controller interrupt type (2018-06-18 09:40:36 -0700)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree fixes for
> 4.18, please pull the following:
>
> - Ray fixes the I2C and PCIe interrupt types for the Cygnus SoC
>
> - Florian fixes the I2C and PCIe interrupts for the Northstar
>   (BCM5301x), Northstar Plus and Hurricane 2 SoCs

Merged, thanks. What's the problem seen, btw? Just for correctness
sake or did it cause actual problems?


-Olof
