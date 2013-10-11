From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 11 Oct 2013 15:08:18 -0700
Subject: [GIT PULL v2] Keystone SOC updates for v3.13
In-Reply-To: <1381450596-27199-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Thu, 10 Oct 2013 20:16:36 -0400")
References: <1381450596-27199-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <877gdj8nql.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Kevin,
>
> Please pull below Keystone SOC updates for v3.13. I moved the PM bus
> code under machine directory and renamed as 'domain' as you suggested.

Thanks for the quick respin.

> As discussed on irc(Olof), the pull request is build on top of v3.13-rc4
> because of dependent commit c2b9e974{dma/Kconfig: Make TI_EDMA select
> TI_PRIV_EDMA}. The pull request carries Kconfig update patch {dma: Allow
> TI_EDMA selectable for ARCH_KEYSTONE} with Vinod Koul's ack as per
> alignment on the mailing list[1]. The clock driver support is already
> applied by Mike to his 3.13 clk-next [2]
>
> The following changes since commit 4385a83d19be799c21af43fbb1ac90364d7a2384:
>
>   ARM: keystone: Enable I2C and SPI bus support (2013-10-10 19:52:18 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc-for-arm-soc
>
> for you to fetch changes up to 4385a83d19be799c21af43fbb1ac90364d7a2384:
>
>   ARM: keystone: Enable I2C and SPI bus support (2013-10-10 19:52:18 -0400)
>
> ----------------------------------------------------------------
> SOC updates for Keystone II devices:
>
> - Clock tree support
> - Clock management support using PM core
> - Keystone config update for EMDA with ack from Vinod
> - Enable SPI and I2C drivers
>
> ----------------------------------------------------------------

Pulled into next/soc.

Kevin
