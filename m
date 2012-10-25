From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 25 Oct 2012 17:40:08 +0100
Subject: Question about move atmel audio part to DT support
In-Reply-To: <50810CC8.4050009@atmel.com>
References: <5080F54F.4000600@atmel.com>
 <50810CC8.4050009@atmel.com>
Message-ID: <20121025164008.GQ18814@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 04:18:16PM +0800, Bo Shen wrote:

> Cc:
>    linux-arm-kernel mailing list
>    devicetree-discuss mailing list
>    alsa-devel mailing list
>    linux-sound mailing list

Better to resend for things like this rather than double quote.

> 
> >   Atmel audio part has three platform device:
> >     -> atmel ssc: ssc library (different SOC has different number)
> >     -> atmel ssc dai: dai for audio
> >     -> atmel pcm: for pdc or dma transfer (now only support pdc, dma
> >support will add soon)

> >  In DT support kernel, I don't find any similar case. So, if I want to
> >keep ssc as library, and use dai to register pcm. Then the dts file will
> >like:

I'm not seeing anything at all unusual about the above situation - it'd
help if you could explain what you think is complex here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/475b32d6/attachment.sig>
