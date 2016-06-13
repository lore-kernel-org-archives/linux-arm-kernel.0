From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 13 Jun 2016 16:35:21 +0200
Subject: [PATCH v2 4/4] ARM: dts: r8a7790: lager: use demuxer for IIC3/I2C3
In-Reply-To: <1465370066-8450-5-git-send-email-horms+renesas@verge.net.au>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <1465370066-8450-5-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160613143521.GD1603@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  		i2c9 = "i2cexio1";
>  		i2c10 = "i2chdmi";
>  		i2c11 = "gpioi2c";
> +		i2c12 = "i2cpwr";

To make it easier for users, we should maybe group them?

i2c8+9: additional gpio busses
i2c10-13: i2cexioX

?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/637debee/attachment-0001.sig>
