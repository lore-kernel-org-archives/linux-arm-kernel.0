From: eric@anholt.net (Eric Anholt)
Date: Thu, 08 Oct 2015 16:44:31 -0700
Subject: [PATCH v5] clk: bcm2835: Add support for programming the audio
 domain clocks.
In-Reply-To: <20151008005532.GB26883@codeaurora.org>
References: <1444181140-3570-1-git-send-email-eric@anholt.net>
 <20151008005532.GB26883@codeaurora.org>
Message-ID: <87h9m17wo0.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 10/06, Eric Anholt wrote:
>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
>> index dd295e4..b4d4421 100644
>> --- a/drivers/clk/bcm/clk-bcm2835.c
>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>> @@ -17,10 +17,273 @@
>>  #include <linux/clk-provider.h>
>>  #include <linux/clkdev.h>
>>  #include <linux/clk/bcm2835.h>
>> +#include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/clock/bcm2835.h>
>
> Please include slab.h for the kzalloc usage

OK, I think I've done all of your feedback now, as well as Stephen
Warren's.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151008/048dbfa0/attachment.sig>
