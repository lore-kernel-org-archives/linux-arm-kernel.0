From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Aug 2017 10:43:41 +0200
Subject: [PATCH 3/3] mfd: twl: move header file out of I2C realm
In-Reply-To: <20170814064247.qvggx4ito4vgjqvs@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
 <20170706070352.xdecvsnremwqed72@dell>
 <20170813133700.tv4ka7anvbzcplr7@ninjato>
 <20170814064247.qvggx4ito4vgjqvs@dell>
Message-ID: <20170814084340.65morabelapfegph@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Given the triviality of the change for non-MFD subsystems, can we apply
> > this for 4.14?
> 
> I can't apply anything without Acks for *all* of the subsystems above.

Well, there are cases when you can. Those should be exceptions and well
justified, of course.

> My suggestion would be to collect the Acks you've received up until
> this point and identify which SS's are still lacking in change log
> section of a RESEND.

I agree, though, that I can try a second round to get the acks.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170814/995d6d46/attachment-0001.sig>
