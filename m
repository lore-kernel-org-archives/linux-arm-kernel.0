From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 05 Aug 2013 12:56:28 +0300
Subject: [PATCH v5 0/6] mtd: atmel_nand: enable Nand Flash Controller
 (NFC) support
In-Reply-To: <1372845034-5579-1-git-send-email-josh.wu@atmel.com>
References: <1372845034-5579-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1375696588.14869.421.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-03 at 17:50 +0800, Josh Wu wrote:
> This patch series enable NFC support for SAMA5 soc. It can send command,
> address cycles automaticly. Also when enable NFC sram, NFC will transfer
> data to sram. Which can save lots of cpu time.
> 
> The mtd speed test results (non-NFC vs NFC), run in sama5d3x-ek with DMA
> enable, is in the end of this patch.

Please, also all all the acks to the patches.

-- 
Best Regards,
Artem Bityutskiy
