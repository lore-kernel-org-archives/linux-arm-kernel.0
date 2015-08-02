From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 2 Aug 2015 03:59:00 +0200
Subject: [PATCH V2] i2c: s3c2410: remove unused variable
In-Reply-To: <1437164839-9287-1-git-send-email-laurent.navet@gmail.com>
References: <1437164839-9287-1-git-send-email-laurent.navet@gmail.com>
Message-ID: <20150802015900.GA1726@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> @@ -565,7 +564,7 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
>  	tmp &= ~S3C2410_IICCON_IRQPEND;
>  	writel(tmp, i2c->regs + S3C2410_IICCON);
>   out:
> -	return ret;
> +	return;

What about removing out: and return as well?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150802/2360b276/attachment.sig>
