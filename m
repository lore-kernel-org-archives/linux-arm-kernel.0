From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Feb 2013 18:35:42 +0000
Subject: [PATCH v4 1/3] ASoC: tlv320aic3x: Convert mic bias to a supply
 widget
In-Reply-To: <1359636786-7056-2-git-send-email-gururaja.hebbar@ti.com>
References: <1359636786-7056-1-git-send-email-gururaja.hebbar@ti.com>
 <1359636786-7056-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20130204183542.GS4720@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 06:23:04PM +0530, Hebbar Gururaja wrote:
> Convert MicBias widgets to supply widget.
> 
> On tlv320aic3x, Mic bias power on/off shares the same register bits
> with output mic bias voltage.  So, when power on mic bias, we need
> reclaim it to voltage value.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/e1d80052/attachment.sig>
