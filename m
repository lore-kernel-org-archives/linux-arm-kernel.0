From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 20 Dec 2013 12:22:04 -0800
Subject: [GIT PULL 00/69] Renesas ARM based SoC DT updates for v3.14
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Fri, 13 Dec 2013 11:31:12 +0900")
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <878uvfgtn7.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC DT updates for v3.14.
>
> This pull request is based on renesas-soc-for-v3.14 (v2) which I
> also sent a pull request for today.
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.14
>
> for you to fetch changes up to 1fd219561a4afc51b5f257692f3581546434db5b:
>
>   ARM: shmobile: marzen: enable HSPI0 in DTS (2013-12-10 17:27:25 +0900)
>
> ----------------------------------------------------------------
> Renesas ARM based SoC DT updates for v3.14
>
> * Global
>   - Use interrupt macros
>   - Use #include in device tree sources
>   - Tidyup DT node naming
>
> * emev2 (Emma Mobile EV2) SoC
>   - Setup internal peripheral interrupts as level high
>   - Use interrupt macros in DT files
>   - Add clock tree description in DT
>
> * r8a7791 (R-Car M2) SoC
>   - Correct GPIO resources
>
> * r8a7791 (R-Car M2) based Koelsch board
>   - Configure PFC and GPO
>   - Use r8a7791 suffix for IRQC compat string
>   - Add DT reference
>
> * r8a7790 (R-Car H2) based Lager board
>   - Include all 4 GiB of memory
>   - Use r8a7790 suffix for IRQC and MMCIF compat strings
>   - Enable MMCIF
>   - Add default PFC settings
>
> * r8a7778 (R-Car M1) SoC
>   - Suffix for INTC compat string
>   - Add HSPI, MMCIF, SDHI and I2C suppport on DTSI
>   - Correct pin control device addresses
>
> * r8a7778 (R-Car M1) based Bock-W board
>   - Use falling edge IRQ for LAN9221 in DT reference
>   - Enable I2C, HSPI0, MMCIF and SDHI
>   - Correct MMC pin conflict
>   - Remove manual PFC settings from DT reference
>   - Add default PFC settings
>
> * r8a7779 (R-Car H1) SoC
>   - Add HSPI and SDHI support
>   - Suffix for INTC compat string
>
> * r8a7779 (R-Car H1) based Marzen board
>   - Enable HSPI0 and SDHI in DTS
>   - Remove SDHI0 WP pin setting
>   - Use falling edge IRQ for LAN9221 in DT reference
>   - Add SDHI support
>
> * r8a7740 (R-Mobile A1) SoC
>   - Suffix for INTC compat string
>   - Add FSI support via DTSI
>   - Use interrupt macros
>
> * r8a7740 based Armadillo board
>   - Add FSI support for DTS
>   - Use low level IRQ for ST1231 in DT reference
>
> * r8a73a4 (SH-Mobile APE6) SoC
>   - Use interrupt macros in DT files
>
> * r8a73a4 (R-Mobile APE6) based ape6evm board
>   - Include all 2 GiB of memory
>
> * r8a73a0 (SH-Mobile AG5) SoC
>   - Correct SDHI compat string
>
> * r8a73a0 (SH-Mobile AG5) based kzm9d board
>   - Add GPIO keys and Add PCF8575 GPIO extender to DT
>   - Enable DSW2 with gpio-keys
>   - Use falling edge IRQ for LAN9221 in DT reference
>
> ----------------------------------------------------------------

Pulled into next/dt,

Thanks,

Kevin
