From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Feb 2018 23:26:57 +0100
Subject: [GIT PULL 1/2] Broadcom devicetree fixes for 4.16
In-Reply-To: <20180228005130.31856-1-f.fainelli@gmail.com>
References: <20180228005130.31856-1-f.fainelli@gmail.com>
Message-ID: <CAK8P3a2sAz3LStzt=Zrsh+TEAfJKriy8P7HkJLJjUnHgAxenDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 1:51 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.16/devicetree-fixes
>
> for you to fetch changes up to 2944866ac5b37e24ce1e646d2aaf472148e4a43e:
>
>   ARM: dts: bcm283x: Move arm-pmu out of soc node (2018-02-27 16:42:09 -0800)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoCs Device Tree fixes for
> 4.16, please pull the following:
>
> - Mathieu fixes leading 0x and 0's from bindings and Device Tree source
>   files, he has done this treewide and most of his changes are already in
>   4.16
>
> - Stefan provides two changes to the BCM283x DTS files in order to fix
>   DTC warnings
>
> - Florian fixes the amount of RAM on the BCM958625HR reference board to
>   properly limit to what is initialized by the bootloader

Pulled into fixes, thanks!

        Arnd
