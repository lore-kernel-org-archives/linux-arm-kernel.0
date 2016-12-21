From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Dec 2016 13:20:09 +0100
Subject: [PATCH 1/7] Documentation: DT: bindings: iio: adc: add
 documentation for Allwinner SoCs' GPADC driver
In-Reply-To: <61dc140a-5ef1-f55d-e749-cb816a014705@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
 <20161220102709.9504-2-quentin.schulz@free-electrons.com>
 <20161220142554.rcocnculfehiwhpn@lukather>
 <61dc140a-5ef1-f55d-e749-cb816a014705@free-electrons.com>
Message-ID: <20161221122009.2gcidvhnmomsiagc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 20, 2016 at 04:43:58PM +0100, Quentin Schulz wrote:
> >> +
> >> +Optional properties:
> >> +(for use with thermal framework for CPU thermal throttling for example, and/or
> >> + IIO consumers)
> >> + - #thermal-sensor-cells = <0>; (see
> >> +Documentation/devicetree/bindings/thermal/thermal.txt)
> >> + - #io-channel-cells = <0>; (see
> >> +Documentation/devicetree/bindings/iio/iio-bindings.txt)
> > 
> > I wouldn't list that as optional.
> 
> In what sense? Do you mean you wouldn't put them here at all or you
> would require them?

I would require them.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161221/8e164a7c/attachment.sig>
