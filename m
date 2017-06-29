From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jun 2017 17:22:52 +0200
Subject: [PATCH] multi_v7_defconfig: Enable OMAP MTD and DM816 AHCI
In-Reply-To: <20170626073333.GR3730@atomide.com>
References: <1498045359-27376-1-git-send-email-trini@konsulko.com>
 <20170626073333.GR3730@atomide.com>
Message-ID: <CAK8P3a1qN79DhoQ-SCNaF8i+60N0RDMOGpfWQ+gRLBdjKcXoPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 9:33 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tom Rini <trini@konsulko.com> [170621 04:42]:
>> A wide variety of TI platforms support NAND via the
>> CONFIG_MTD_NAND_OMAP2 driver (and related BCH options), so enable this.
>> In addition, multi_v7_defconfig supports the dm8168-evm and that
>> supports root being on a SATA drive, so build the DM816 AHCI driver into
>> the resulting kernel as well.
>
> Best that Arnd picks up this one directly:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Pulled into next/defconfig, thanks!

        Arnd
