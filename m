From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 26 Oct 2012 09:26:18 +0800
Subject: Question about move atmel audio part to DT support
In-Reply-To: <20121025164008.GQ18814@opensource.wolfsonmicro.com>
References: <5080F54F.4000600@atmel.com> <50810CC8.4050009@atmel.com>
 <20121025164008.GQ18814@opensource.wolfsonmicro.com>
Message-ID: <5089E6BA.2090902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 10/26/2012 0:40, Mark Brown wrote:
> On Fri, Oct 19, 2012 at 04:18:16PM +0800, Bo Shen wrote:
>
>> Cc:
>>     linux-arm-kernel mailing list
>>     devicetree-discuss mailing list
>>     alsa-devel mailing list
>>     linux-sound mailing list
>
> Better to resend for things like this rather than double quote.

Got it. Thanks.

>>
>>>    Atmel audio part has three platform device:
>>>      -> atmel ssc: ssc library (different SOC has different number)
>>>      -> atmel ssc dai: dai for audio
>>>      -> atmel pcm: for pdc or dma transfer (now only support pdc, dma
>>> support will add soon)
>
>>>   In DT support kernel, I don't find any similar case. So, if I want to
>>> keep ssc as library, and use dai to register pcm. Then the dts file will
>>> like:
>
> I'm not seeing anything at all unusual about the above situation - it'd
> help if you could explain what you think is complex here?

This is only a little different with others. We have one more DT node: 
dai in dts file. I am worry about this won't be acceptable.

Anyway, I have sent out the patches. Please help review the code if 
possible.
Thanks.

BRs,
Bo Shen
