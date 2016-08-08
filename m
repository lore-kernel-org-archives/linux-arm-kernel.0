From: bp@alien8.de (Borislav Petkov)
Date: Mon, 8 Aug 2016 15:37:12 +0200
Subject: [PATCH 3/3] ARM: dts: Add Arria10 SD/MMC EDAC devicetree entry
In-Reply-To: <1470153381-20517-4-git-send-email-tthayer@opensource.altera.com>
References: <1470153381-20517-1-git-send-email-tthayer@opensource.altera.com>
 <1470153381-20517-4-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160808133712.GB29563@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 10:56:21AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree entries needed to support the Altera SD/MMC
> FIFO buffer EDAC on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)

This needs an Ack by Dinh.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
