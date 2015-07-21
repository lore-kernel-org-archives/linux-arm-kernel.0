From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 21 Jul 2015 22:52:50 +0200
Subject: [PATCH v3 4/4] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <2107735.0gMPOtIgYc@fb07-iapwap2>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <4778199.vGjAP5lpOS@fb07-iapwap2> <55AE0803.10603@mail.ru>
 <2107735.0gMPOtIgYc@fb07-iapwap2>
Message-ID: <20150721205250.GA1521@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> It's up to you. I think if the NV guys are ok with the tegra i2c change, 
> Wolfram can merge it right away for 4.3.

I asked him to resend, because I *want* to merge it for 4.3 :) Only the
slave-mode enablement for i2c, of course. The other patches need to go
via some other tree (when they are done).

So, V4 with only this one patch is a good idea in my book.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150721/0f1617cc/attachment.sig>
