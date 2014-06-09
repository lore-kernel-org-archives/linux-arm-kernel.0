From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 9 Jun 2014 05:46:13 +0000 (UTC)
Subject: OMAP baseline test results for v3.15-rc8
In-Reply-To: <538C39BB.9020809@compulab.co.il>
References: <alpine.DEB.2.02.1406020749100.21503@utopia.booyaka.com>
 <538C39BB.9020809@compulab.co.il>
Message-ID: <alpine.DEB.2.02.1406090543001.21441@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Jun 2014, Dmitry Lifshitz wrote:

> CM-T3517 is a bare-bone CoM without MMC/SD card slot (NAND option).
> MMC/SD card interface (and some other peripherals) are properties of the
> carrier base board SB-T35, which turns this CoM into fully functional board
> SBC-T3517.
> 
> Please, use omap3-sbc-t3517.dtb target.
> 
> Attached Linux v3.15-rc8 boot log using omap2plus_defconfig.

Thanks.  My mistake.  Here's the updated bootlog for that board for 
v3.15-rc8:

http://www.pwsan.com/omap/testlogs/test_v3.15-rc8/20140608202958/boot/cmt3517/cmt3517_log.txt

- Paul
