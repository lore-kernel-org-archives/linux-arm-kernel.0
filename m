From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 5 Aug 2013 19:28:52 +0800
Subject: [PATCH v5 0/6] mtd: atmel_nand: enable Nand Flash Controller
 (NFC) support
In-Reply-To: <1375696588.14869.421.camel@sauron.fi.intel.com>
References: <1372845034-5579-1-git-send-email-josh.wu@atmel.com>
 <1375696588.14869.421.camel@sauron.fi.intel.com>
Message-ID: <51FF8C74.2060204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Artem

On 8/5/2013 5:56 PM, Artem Bityutskiy wrote:
> On Wed, 2013-07-03 at 17:50 +0800, Josh Wu wrote:
>> This patch series enable NFC support for SAMA5 soc. It can send command,
>> address cycles automaticly. Also when enable NFC sram, NFC will transfer
>> data to sram. Which can save lots of cpu time.
>>
>> The mtd speed test results (non-NFC vs NFC), run in sama5d3x-ek with DMA
>> enable, is in the end of this patch.
> Please, also all all the acks to the patches.
>

I already sent out the v6 for this NFC patch series. Which is rebased on 
the top of l2-mtd.git and add the Acks in patch. Thanks for the remind.

Best Regards,
Josh Wu
