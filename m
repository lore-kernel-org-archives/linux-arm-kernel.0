From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 10 Jul 2012 16:50:33 +1000
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
Message-ID: <20120710165033.ab9ffbee81e2aeb03cad8d00@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Tue, 10 Jul 2012 16:41:30 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/i2c/busses/i2c-nomadik.c between commit af97bace2cca
> ("i2c-nomadik: move header to <linux/platform_data/i2c-nomadik.h>") from

Also commit 235602146ec9 ("i2c-nomadik: turn the platform driver to an
amba driver")

> the i2c-embedded tree and commits 32e42c687e0a ("ARM: ux500: Remove
> unused i2c platform_data initialisation code") and 8214fd238a66 ("i2c:
> Add Device Tree support to the Nomadik I2C driver") from the arm-soc tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.
> Please check this and talk to each other ...

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/463115cb/attachment.sig>
