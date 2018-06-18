From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 18 Jun 2018 20:06:11 +0900
Subject: [PATCH 00/11] Split i2c_lock_adapter into i2c_lock_root and
 i2c_lock_segment
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
Message-ID: <20180618110610.cwvkke6klc46kzvz@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I suggest that Wolfram takes this series through the I2C tree
> and creates an immutable branch for the other subsystems. The

I'd prefer this, too. Are the other subsystem maintainers fine with
that?

I am very positive on the series. I just have one comment which I just
posted. It looks good in general.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180618/38e24c06/attachment.sig>
