From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 5 Dec 2015 18:24:39 +0000
Subject: [PATCH v5 5/5] iio: humidity: si7020: add No Hold read mode
In-Reply-To: <20151130173324.GG9554@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-5-git-send-email-nicola@corna.info>
 <56349644.2060308@kernel.org> <20151130173324.GG9554@katana>
Message-ID: <56632BE7.2050000@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/15 17:33, Wolfram Sang wrote:
> On Sat, Oct 31, 2015 at 10:21:56AM +0000, Jonathan Cameron wrote:
>> On 29/10/15 11:34, Nicola Corna wrote:
>>> The Si7013/20/21 modules support 2 read modes:
>>>  * Hold mode (blocking), where the device stretches the clock until the end
>>> of the measurement
>>>  * No Hold mode (non-blocking), where the device replies NACK for every I2C
>>> call during the measurement
>>> Here the No Hold mode is implemented, selectable with the blocking_io
>>> variable within si7020_platform_data. The default mode is Hold, unless the
>>> adapter does not support clock stretching, in which case the No Hold mode
>>> is used.
>>>
>>> Signed-off-by: Nicola Corna <nicola@corna.info>
>> I'm fine with this.  The dependency below should I think show up in the
>> coming merge window, so this lot might as well go via Wolfram.
>>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> Not sure, will think about it...
> 
Nicola,

If Wolfram doesn't pick this up, please ping me after the next merge window.
Whilst I'll still have it in my queue, it'll be so long ago by then I'll probably
miss it!

Jonathan
