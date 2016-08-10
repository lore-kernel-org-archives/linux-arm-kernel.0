From: bp@alien8.de (Borislav Petkov)
Date: Wed, 10 Aug 2016 14:48:34 +0200
Subject: [PATCHv2 0/3] Add SD/MMC EDAC for Altera Arria10
In-Reply-To: <1470753653-23465-1-git-send-email-tthayer@opensource.altera.com>
References: <1470753653-23465-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160810124834.GA438@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 09:40:50AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the SD/MMC FIFO EDAC module which is a dual-port RAM as
> opposed to the other Arria10 peripheral's single port RAM FIFOs.
> 
> Thor Thayer (3):
>   Documentation: dt: socfpga: Add Arria10 SD-MMC EDAC binding
>   EDAC, altera: Add Arria10 SD-MMC EDAC support
>   ARM: dts: Add Arria10 SD/MMC EDAC devicetree entry
> 
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   19 ++
>  arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  |   12 ++
>  drivers/edac/Kconfig                               |    7 +
>  drivers/edac/altera_edac.c                         |  188 +++++++++++++++++++-
>  drivers/edac/altera_edac.h                         |    5 +
>  5 files changed, 230 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
