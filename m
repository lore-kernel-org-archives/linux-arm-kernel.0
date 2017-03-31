From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 10:59:48 +0200
Subject: [GIT PULL 7/7] Broadcom drivers changes for 4.12
In-Reply-To: <20170324175807.27272-7-f.fainelli@gmail.com>
References: <20170324175807.27272-1-f.fainelli@gmail.com>
 <20170324175807.27272-7-f.fainelli@gmail.com>
Message-ID: <CAK8P3a322xx0aUhxd1sNORk-M7toY9a7yoAu-8MuPEGh70BvnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 6:58 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
>
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.12/drivers
>
> for you to fetch changes up to bd0faf08dc7fcb3e555b35f556c9012b3c93de3b:
>
>   soc: bcm: brcmstb: Match additional compatible strings (2017-03-05 17:00:57 -0800)
>
> ----------------------------------------------------------------
> This pull request contains Broadcom ARM-based SoC drivers updates for 4.12,
> please pull the following changes:
>
> - Florian updates the Broadcom STB GISB arbiter driver with a bunch of
>   compatible strings for MIPS-based STBs found under arch/mips/boot/dts/brcm/ in
>   order for the SoC identification driver to recognize these chips

Pulled into next/drivers, thanks!

      Arnd
