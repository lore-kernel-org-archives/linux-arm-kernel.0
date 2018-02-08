From: joonas.kylmala@iki.fi (=?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?=)
Date: Thu, 08 Feb 2018 10:26:00 +0000
Subject: [PATCH v2 1/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 from
 dts to dtsi
In-Reply-To: <20180208085221.zifabhit5adjodb7@flea>
References: <20180207204805.16884-1-joonas.kylmala@iki.fi>
 <20180207204805.16884-2-joonas.kylmala@iki.fi>
 <20180208085221.zifabhit5adjodb7@flea>
Message-ID: <df393f0c-cbe0-c6f2-c53c-37c10a3dac00@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard:
> Also, wouldn't the H5 boards need some change too?

Definitely. I was just looking for all the dts files in
arch/arm/boot/dts/ and didn't even realize there was also
arch/arm64/boot/dts/.

I will send soon a new version of the patchset!

Joonas
