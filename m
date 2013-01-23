From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 23 Jan 2013 15:14:45 +0100
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
In-Reply-To: <CA+8Hj83n+pC+a6bYOOH1b61DTqSjpKsxyKDgDL2pCRKxTq4EXg@mail.gmail.com>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
 <20130123125001.GG16264@pengutronix.de>
 <CA+8Hj80=Mk1gMSC9gcRT_XPFrEdRxifaB9FNMtkn3BkUkv9bGA@mail.gmail.com>
 <20130123134936.GH16264@pengutronix.de>
 <CA+8Hj83n+pC+a6bYOOH1b61DTqSjpKsxyKDgDL2pCRKxTq4EXg@mail.gmail.com>
Message-ID: <20130123141445.GA2758@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The names of the two entries are not the same, one is "24c512", the
> other is "24c512b".

I do understand that. There are TONS of 24c512 variants out there.

> My original idea to add the new entry is to count on the name
> difference to do different system reset operations.

Your devicetree may have both names, but at24 doesn't need it since
there is no code involved handling the difference.

> The commit message of the patch which adds 24c32 support for MX28EVK
> tells that "mx28evk has a free slot U50 that can be used to populate
> an I2C EEPROM.".

I do know that, too. You can put other things there, too. But well, not
worth the hazzle...

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/f1167045/attachment.sig>
