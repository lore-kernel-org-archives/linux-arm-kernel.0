From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 30 Oct 2014 14:25:37 +0100
Subject: [PATCH 3/3] I2C: mediatek: Add driver for MediaTek I2C controller
In-Reply-To: <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
References: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
 <1414561058-23803-4-git-send-email-xudong.chen@mediatek.com>
 <CABuKBe+RXboBEZD7Bu_kSbVwiapJJcAuuw_wo=xw67osJWJ20w@mail.gmail.com>
Message-ID: <20141030132537.GB23852@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +obj-$(CONFIG_I2C_MT65XX)       += i2c-mt65xx.o
> 
> As it works for mt65xx and mt81xx series, better rename it to i2c-mtk.c

That is a bit too generic IMO. It is likely that we will see some
totally different I2C core from MTK in the future. Plus, it is not
uncommon that a driver initially for SoC-X supports SoC-Y, too.

Thanks for pointing out the other remarks.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/df9e30d8/attachment.sig>
