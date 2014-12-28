From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 28 Dec 2014 16:54:11 +0200
Subject: [PATCH v2] ARM: dts: cm-t3x: add NAND support
In-Reply-To: <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
References: <54A00BD6.8010507@compulab.co.il>
 <1419777049-25271-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <54A01993.3060002@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/14 16:30, Dmitry Lifshitz wrote:
> CM-T3517, CM-T3530 and CM-T3730 features NAND storage chip connected to
> GPMC bus.
> 
> Add GPMC DT entry into the root DT file omap3-cm-t3x.dtsi, common for
> all three modules.
> 
> NAND timings are calculated to be safe for CM-T3x devices as it works
> now in non DT boot (in this case the timings are updated by U-Boot).
> 
> Update GPMC ranges in boards DT files to include all connected devices.
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>


-- 
Regards,
Igor.
