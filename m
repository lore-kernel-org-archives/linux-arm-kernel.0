From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 7 Dec 2017 11:49:15 +0100
Subject: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
In-Reply-To: <CAFcVECLWwo+OxSGAGYJfMSesjNT51X+Cwk+E_-RQk7gsEXy2YQ@mail.gmail.com>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
 <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
 <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com>
 <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
 <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
 <CAFcVECLWwo+OxSGAGYJfMSesjNT51X+Cwk+E_-RQk7gsEXy2YQ@mail.gmail.com>
Message-ID: <20171207104915.fdqkj35ga2yxeg3n@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I attach a patch of the changes to the i2c driver showing my debug in
> > this driver.
> > As I said I am happy to send more verbose bug output - I have about 36
> > odd runs with 9 occurences of the bug.
> > Once it happen twice in the one run
> >
> > I include the crashing line from the runs where the bug occured (I
> > added more diagnostics as the runs progressed):
> 
> I'll check with out HW team as well and check your flow to
> see if we can reproduce it; will also check if the existing errata
> has larger scope.
> I'll let you know if we require further assistance with debug
> next week.

Any news here?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/bb2a5f6f/attachment.sig>
