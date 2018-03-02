From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 2 Mar 2018 14:58:54 +0100
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302125907.GA9418@n2100.armlinux.org.uk>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk>
Message-ID: <20180302135854.76ue5jzsg7lvxjxw@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> It needs platform maintainers to be motivated to fix it, and one way to
> provide that motivation is for subsystem maintainers to say no to patches
> like this.  If patches like this get accepted, then the "problem" gets
> solved, and there is very little motivation to fix the platform itself.

Yes, I can see this. I will drop / revert the patch.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/d2724e24/attachment-0001.sig>
