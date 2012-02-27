From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 27 Feb 2012 23:24:14 +0100
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
In-Reply-To: <CACxGe6vU2dSpRrqd2y=ssgVsWuwpuvFtja9YcUAQA_ETWcwCYg@mail.gmail.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
 <20120227134112.GB3191@opensource.wolfsonmicro.com> <4F4B8A85.7060603@ti.com>
 <CACxGe6vU2dSpRrqd2y=ssgVsWuwpuvFtja9YcUAQA_ETWcwCYg@mail.gmail.com>
Message-ID: <4F4C028E.2000405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/27/2012 11:17 PM, Grant Likely wrote:
> On Mon, Feb 27, 2012 at 6:52 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Mark,
>>
>>
>> On 2/27/2012 2:41 PM, Mark Brown wrote:
>>>
>>> On Mon, Feb 27, 2012 at 06:01:20PM +0530, Rajendra Nayak wrote:
>>>
>>>> Depending on what order Mark happens to pull them in, I am fine
>>>> re-sending adding support for the 2 twl6030 fixed regulators.
>>>
>>>
>>> Please can you guys come up with a single unified series for this stuff
>>> - I'll hold off on applying anything to allow you to do this.
>>
>>
>> The issue is that the initial TWL regulator series from Rajendra will depend
>> on the twl core DT support I have that depends on the irq_domain series from
>> Grant...
>
> If it depends on the irqdomain tree, then just merge that tree into
> yours.  That tree is stable now for exactly that reason.  You can rely
> on it.

I've just posted a pull request [1] to Tony that will merge your series 
into an OMAP DT branch to be a base for further OMAP DT series.

Regards,
Benoit


[1] http://www.spinics.net/lists/linux-omap/msg65346.html
