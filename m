From: rogershimizu@gmail.com (Roger Shimizu)
Date: Mon, 20 Jul 2015 22:50:00 +0900
Subject: [PATCH 0/2] ARM: DTS support for Linkstation LS-WTGL (orion5x)
In-Reply-To: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
References: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <CAEQ9gE=GAE7RbzkNWBvPxbH0OSsc7QP3+Kvsig+krQ2cA8=7bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew, Jason,

Could you help to review my patchset on Linkstation LS-WTGL (orion5x), please?
Thank you and look forward to your feedback!

Cheers,
Roger

On Tue, Jul 14, 2015 at 10:00 PM, Roger Shimizu <rogershimizu@gmail.com> wrote:
> Dear Orion5x Maintainer,
>
> I'd like to add DTS support for a bit older linkstation orion5x device, LS-WTGL.
> I have tested againt latest kernel next/dt branch on my box and it works fine.
> Please consider to merge. Thank you!
>
> Cheers,
> Roger
>
> Roger Shimizu (2):
>   ARM: dts: add buffalo linkstation ls-wtgl
>   ARM: defconfig: add DT support for orion5x_defconfig
>
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 242 +++++++++++++++++++++++
>  arch/arm/configs/orion5x_defconfig               |   4 +
>  3 files changed, 247 insertions(+)
>  create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
>
> --
> 1.9.1
>
