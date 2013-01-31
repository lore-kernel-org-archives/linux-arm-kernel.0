From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 Jan 2013 19:24:16 +0800
Subject: [PATCH v3 1/4] ASoC: tlv320aic3x: Convert mic bias to a supply
 widget
In-Reply-To: <1359631394-9511-2-git-send-email-gururaja.hebbar@ti.com>
References: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
 <1359631394-9511-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20130131112414.GE11078@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 04:53:10PM +0530, Hebbar Gururaja wrote:

> :100644 100644 e7b98f4... f47c3f5... M	Documentation/devicetree/bindings/sound/tlv320aic3x.txt
> :100644 100644 ffd9bc7... 9407fd0... M	include/sound/tlv320aic3x.h
> :100644 100644 4989143... 65d09d6... M	sound/soc/codecs/tlv320aic3x.c
> :100644 100644 6db3c41... e521ac3... M	sound/soc/codecs/tlv320aic3x.h

As mentioned when you posted this before this patch needs to update the
machine drivers using the device too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/0ad46819/attachment.sig>
