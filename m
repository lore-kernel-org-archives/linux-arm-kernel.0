From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 6 Aug 2014 09:20:17 +0200
Subject: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <30487e0abf4b4564af296d17f5cebf49@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <53E0C498.6070608@gmail.com>
 <30487e0abf4b4564af296d17f5cebf49@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <20140806072017.GA2730@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> > 			     struct i2c_msg *msgs)
> > 
> > run checkpatch.pl on this patch...
> 
> Sorry for my code style. I will match open parenthesis in this case.

FYI, I am not strict on the open parenthesis thingie.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140806/134fb5e3/attachment.sig>
