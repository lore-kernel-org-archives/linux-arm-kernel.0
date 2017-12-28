From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 28 Dec 2017 14:02:07 +0100
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: select CONFIG_RTC_DRV_SNVS
In-Reply-To: <1514453660-15373-1-git-send-email-peng.fan@nxp.com>
References: <1514453660-15373-1-git-send-email-peng.fan@nxp.com>
Message-ID: <CAJKOXPcda4s-H=Ks5hby950Ecybj2yp_WQj4PNja2d_fn_eMrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 10:34 AM, Peng Fan <peng.fan@nxp.com> wrote:
> Select CONFIG_RTC_DRV_SNVS for i.MX6 to use RTC to wakeup system
> Patch generated with:
>         make ARCH=arm multi_v7_defconfig
>         select CONFIG_RTC_DRV_SNVS
>         make savedefconfig

No. You are doing hundreds of changes just to enable one option. There
is no way to review this...

Instead if you need to cleanup the defconfig, first do this in
separate step without any other changes.

Then send a patch adding necessary options.

Best regards,
Krzysztof
