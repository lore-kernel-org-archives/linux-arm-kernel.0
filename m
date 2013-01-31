From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 31 Jan 2013 11:27:07 +0000
Subject: [PATCH v3 1/4] ASoC: tlv320aic3x: Convert mic bias to a supply
 widget
In-Reply-To: <20130131112414.GE11078@opensource.wolfsonmicro.com>
References: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
 <1359631394-9511-2-git-send-email-gururaja.hebbar@ti.com>
 <20130131112414.GE11078@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB5A48E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 16:54:16, Mark Brown wrote:
> On Thu, Jan 31, 2013 at 04:53:10PM +0530, Hebbar Gururaja wrote:
> 
> > :100644 100644 e7b98f4... f47c3f5... M	Documentation/devicetree/bindings/sound/tlv320aic3x.txt
> > :100644 100644 ffd9bc7... 9407fd0... M	include/sound/tlv320aic3x.h
> > :100644 100644 4989143... 65d09d6... M	sound/soc/codecs/tlv320aic3x.c
> > :100644 100644 6db3c41... e521ac3... M	sound/soc/codecs/tlv320aic3x.h
> 
> As mentioned when you posted this before this patch needs to update the
> machine drivers using the device too.

The patch-set 2/4 does the same thing. Since I have da850-evm at my end, I 
have modified that machine driver and sent-it as 2/4.

> 


Regards, 
Gururaja
