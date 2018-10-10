From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Oct 2018 13:40:34 +0200
Subject: [GIT PULL] i.MX drivers change for 4.20, round 2 (late)
In-Reply-To: <20181008145600.GT3587@dragon>
References: <20181008145600.GT3587@dragon>
Message-ID: <CAK8P3a0qz=w1x3HnWUaFQj-d=03ydTPGu4YhNFBv0Aend14WqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/8/18, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit
> 8d8e3b7d8f06f69005d829d4a195b00ef976004b:
>
>   soc: imx: gpcv2: Switch to SPDX identifier (2018-10-01 13:24:15 +0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> tags/imx-drivers-4.20-2
>
> for you to fetch changes up to b912de514a8759ef558096d7f1c3a0000e0e37f0:
>
>   MAINTAINERS: imx: include drivers/firmware/imx path (2018-10-08 22:11:02
> +0800)
>
> ----------------------------------------------------------------
> i.MX drivers change for 4.20, round 2:
>  - A series from Aisheng Dong to add SCU firmware driver for i.MX8
>    SoCs.  It implements IPC mechanism based on mailbox for message
>    exchange between AP and SCU firmware, and a set of SCU IPC
>    service APIs used by clients like i.MX8 power domain and clock
>    drivers.

Pulled into next/drivers, thanks!

       Arnd
