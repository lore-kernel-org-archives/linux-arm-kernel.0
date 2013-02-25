From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 25 Feb 2013 16:03:50 +0800
Subject: Debugging missing interrupts
In-Reply-To: <1361777691.4640.34.camel@localhost>
References: <1361777691.4640.34.camel@localhost>
Message-ID: <512B1AE6.6070903@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lexa,

On 2/25/2013 15:34, lexa wrote:
>
> Hello.
>
> I have a trouble with debugging SSC interface(or maybe with audio
> codec). I have a board based on Atmel AT91 (at91sam9m10g45) and codec TI
> tlv320aic3106(using driver tlv320aic3x) connected to SSC interface in
> I2S mode.

Which kernel version do you use?
SSC work as master or slave?

> Playback is works well, but the capture cause trouble.
> The problem is that arecord don't capture any data, he just writes wav
> header and nothing more.

Which command do you use for recording? (it will give sample rate, 
format, and etc)

> Interrupt counter on ssc0 does not increased during capture.
> Also i checked data and clock lines by oscilloscope, and clearly see
> that clock and data transmitting from audio codec during capture.
> It's seem to me, that cpu somewhat doesn't accept data from codec. But i
> don't understand why, and how to debug this.
>
> I know that provided information is insufficient, but i simply don't
> know how to get more detailed information about this problem.

Best Regards,
Bo Shen
