From: florian.meier@koalo.de (Florian Meier)
Date: Wed, 22 May 2013 19:11:09 +0200
Subject: [PATCH] ASoC: Add support for BCM2708
In-Reply-To: <519CEF3C.4000502@wwwdotorg.org>
References: <519CD1CC.8070507@koalo.de> <519CE2B7.8080704@wwwdotorg.org>
 <519CED72.40406@koalo.de> <519CEF3C.4000502@wwwdotorg.org>
Message-ID: <519CFC2D.1020008@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.05.2013 18:15, Stephen Warren wrote:
> On 05/22/2013 10:08 AM, Florian Meier wrote:
>> On 22.05.2013 17:22, Stephen Warren wrote:
>>> On 05/22/2013 08:10 AM, Florian Meier wrote:
>>>> This driver adds support for digital audio (I2S)
>>>> for the BCM2708 SoC that is used by the
>>>> Raspberry Pi. External audio codecs can be
>>>> connected to the Raspberry Pi via P5 header.
>>>>
>>>> It relies on cyclic DMA engine support for BCM2708
>>>> that is not included in this patch.
>>>
>>> This SoC is actually the BCM2835, so the files should be named for that.
>>
>> Actually, I changed the name several times and in the end I sticked to
>> https://github.com/raspberrypi/linux/issues/22
>> but if you think it is better to use BCM2835 I am happy to agree with
>> you and change it.
>>
>>> Upstream only uses device tree for BCM2835. Does this driver support DT?
>>> Where is the DT binding definition file?
>>
>> I have not accomplished to use the mainline kernel and DT with the
>> Raspberry Pi. Do you have any introductive information about how to do this?
> 
> Oh, so is this patch intended for the downstream Raspberry Pi Foundation
> kernel, or the upstream kernel?
> 
> The fact you haven't run it on the upstream kernel implies that you
> intend the patch to be applied to the downstream kernel.
> 
> The fact you sent the driver to all the upstream mailing lists implies
> that you intend the patch to be applied to the upstream kernel.
>
> BTW, I wrote a Google+ post on using the upstream kernel on the Pi:
> https://plus.google.com/101715070573995136397/posts/gWkwrfNfYVm

I chatted with Mark Brown about this issue and if I understood him
correctly he suggested to send it upstream anyway.

Either way, your blog post gives me great hope to get this running
tomorrow so this won't be an issue anymore.
