From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 10 Jul 2012 10:38:19 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
Message-ID: <20120710083819.GA25197@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 04:41:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/i2c/busses/i2c-nomadik.c between commit af97bace2cca
> ("i2c-nomadik: move header to <linux/platform_data/i2c-nomadik.h>") from
> the i2c-embedded tree and commits 32e42c687e0a ("ARM: ux500: Remove
> unused i2c platform_data initialisation code") and 8214fd238a66 ("i2c:
> Add Device Tree support to the Nomadik I2C driver") from the arm-soc tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.
> Please check this and talk to each other ...

Hmm, I can't recall any discussion that the DT support patch should go
in via arm-soc. Did I miss something? Right now, I'd think it should go
in via i2c. I am fine with the other patch going in via arm-soc, but can
carry it as well.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/0211c036/attachment.sig>
