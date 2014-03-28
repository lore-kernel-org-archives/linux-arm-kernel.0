From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Fri, 28 Mar 2014 10:52:00 +0100
Subject: [PATCH 1/1] mxc_nand : allow swapping the Bad block Indicator
 for NFC v1.
In-Reply-To: <20140328091142.GE17250@pengutronix.de>
References: <1345811288.2848.308.camel@sauron.fi.intel.com>
 <1345825064-9147-1-git-send-email-gcembed@gmail.com>
 <201209061056.12386.jbe@pengutronix.de> <504DF9BB.8050509@gmail.com>
 <20120911071715.GB18243@pengutronix.de> <5332DBDD.4090802@gmail.com>
 <20140328091142.GE17250@pengutronix.de>
Message-ID: <53354640.3030400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2014 10:11 AM, Sascha Hauer wrote:
> On Wed, Mar 26, 2014 at 02:53:33PM +0100, Ga?tan Carlier wrote:
>> Hi,
>> I don't see where the problem is. The fact that bad block marker are
>> used or not, is not related to "my" patch. This patch just places
>> data where they should be. If I take the Nand and connect it to a
>> not-bugged NFC controller, all data will be read correctly with data
>> is main area and OOB is spare area.
>>>
>>> In this form the patch is simply not correct and should be dropped.
>>>
>> Now I want to adapt and publish my platform file to latest kernel
>> version and I am still stopped with this biswap patch that is not
>> applied. As I said before, I must not be the only that have used
>> this damned original patch from Freescale that swaps byte in their
>> ATK programming soft, redboot and Kernel and it is impossible to
>> fallback to current NAND handling (without swapping).
>>
>> Is there any chance that if I send this patch against
>> linux-next/master branch, it will be finally accepted. Only people
>> that needs it will use it. There is so much option in menuconfig
>> with so little explaination and mark as "Only say Yes if you known
>> what you do".
>
> I'm ok with supporting a devicetree option that decides whether to do
> bad block marker swapping or not. It shouldn't be a Kconfig option.
devicetree what a wonderful system... I stop fighting.
>
> Sascha
>
>
Best regards,
Ga?tan Carlier.
