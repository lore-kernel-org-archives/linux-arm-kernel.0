From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Aug 2017 17:35:22 +0200
Subject: [GIT PULL] i.MX fixes for 4.13, round 2
In-Reply-To: <20170805130830.GV31819@dragon>
References: <20170805130830.GV31819@dragon>
Message-ID: <CAK8P3a0-4y2OE-n9Liu1_=t1kD0_R16_MOHqgfa-+rz2mP1tNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 5, 2017 at 3:08 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 05969566e6d64113a861adc6c17cbba685c640b3:
>
>   ARM: dts: imx7d-sdb: Put pinctrl_spi4 in the correct location (2017-07-16 09:43:04 +0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.13-2
>
> for you to fetch changes up to 8317562097acec4c9e9750eb91115687931bca35:
>
>   ARM: dts: i.MX25: add ranges to tscadc (2017-08-05 13:22:32 +0800)
>
> ----------------------------------------------------------------
> i.MX fixes for 4.13, round 2:
>  - Add missing 'ranges' property for i.MX25 device tree TSCADC node, so
>    that it's child nodes ADC and TSC device can be probed by kernel.
>  - Fix i.MX GPCv2 power domain driver to request regulator after power
>    domain initialization, since regulator could defer probing and
>    therefore cause power domain initialized twice.


Pulled into fixes, thanks,

     Arnd
