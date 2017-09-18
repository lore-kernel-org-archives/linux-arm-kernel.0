From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 09:36:01 +0200
Subject: [PATCH v4 3/6] iio: adc: sun4i-gpadc-iio: rework code for
 supporting newer THS variants
In-Reply-To: <20170914145251.21784-4-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-4-icenowy@aosc.io>
Message-ID: <20170918073601.oiqshnhhl7yb6fv2@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 10:52:48PM +0800, Icenowy Zheng wrote:
> The SoCs after H3 has newer thermal sensor ADCs, which have two clock
> inputs (bus clock and sampling clock) and a reset. The registers are
> also re-arranged.
> 
> This commit reworks the code, adds the process of the clocks and
> resets, and allows the sampling start/end code and the position of value
> readout register to be altered.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Please split that into separate commits.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/ba964250/attachment.sig>
