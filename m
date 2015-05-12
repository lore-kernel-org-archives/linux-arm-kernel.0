From: wsa@the-dreams.de (wsa at the-dreams.de)
Date: Tue, 12 May 2015 15:00:57 +0200
Subject: [PATCH v7 3/3] I2C: mediatek: Add driver for MediaTek MT8173 I2C
 controller
In-Reply-To: <1430901427-65146-4-git-send-email-eddie.huang@mediatek.com>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <1430901427-65146-4-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150512130057.GC4447@schokonusskuchen.bad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	if (i2c->irq_stat & I2C_RS_TRANSFER)
> +		dev_dbg(i2c->dev, "addr: %x, restart transfer interrupt.\n",
> +				msgs->addr);

I'd tend to leave out this debug message. But you may leave it if you
like. Rest of the patch looks okay.

Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/0de3255d/attachment.sig>
