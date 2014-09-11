From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 11 Sep 2014 16:40:04 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <20140911141257.GC5149@katana>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1410274470-12712-5-git-send-email-wsa@the-dreams.de>
 <16809905.2REViph6WO@fb07-iapwap2> <20140911141257.GC5149@katana>
Message-ID: <20140911144003.GD5149@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> b) could be seen as a configuration thing since the functionality
> backend could be changed at runtime even.

Come to think of it, not only the functionality, also the address can be
changed at runtime. This makes me think it should really not be in DT
after all.

People will probably find out that it is possible to put it in DT, but
it should not be encouraged and they should do it on their own risk.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/b3e4c875/attachment.sig>
