From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Jun 2013 16:01:40 +0200
Subject: [PATCHv4 0/9] Add I2C support for Allwinner SoCs
In-Reply-To: <201306121438.12549.arnd@arndb.de>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <3315236.ZNXhyxmCRd@wuerfel> <20130612113849.GG16699@lukather>
 <201306121438.12549.arnd@arndb.de>
Message-ID: <20130614140140.GB2929@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > The weird thing is that the only difference between the two controllers
> > is the register offsets, and that's it. The state numbers, bit index,
> > etc, are exactly the same.
> 
> Ok, cool. Great someone noticed!

:) First thing I do when reviewing new drivers is a manual fuzzy search
for already known register sets.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/fd37f2b0/attachment.sig>
