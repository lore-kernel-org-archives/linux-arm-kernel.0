From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 20:03:43 +0100
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
In-Reply-To: <CAD=FV=Vp3hwxbDzb+FUhNXy8qW8fTCkgd67jRDV3foT0o9HQuQ@mail.gmail.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
 <20141203111518.GB1039@katana>
 <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
 <20141204184046.GL7944@katana>
 <CAD=FV=Vp3hwxbDzb+FUhNXy8qW8fTCkgd67jRDV3foT0o9HQuQ@mail.gmail.com>
Message-ID: <20141204190342.GM7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > New binding should have the "-ns" suffix, right? So, I'd vote to add the
> > suffix to the new bindings and deprecate the ones used in the designware
> > driver: "i2c-scl-rising-time-ns" and "i2c-scl-falling-time-ns"
> >
> > It might be a little more work now, but it will help us in the future,
> > because it is the correct way to do it.
> 
> OK, that sounds fair.  You're OK with my proposal otherwise?

Yes.

> Are you looking for Addy or me to submit a patch supporting the "-ns"
> suffix on the Designware i2c driver, or should we just use the "-ns"
> suffix in the Rockchip driver and assume someone will later add
> support for the new binding in the Designware i2c driver?

I'd be really happy if you can do it. I'd love to have consistency right
away.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/bd18dcfe/attachment.sig>
