From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2011 11:12:58 +0000
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTinywQZtCpUppZ-2eSqV6s+b+5kDZ6hRVJ36ewgi@mail.gmail.com>
References: <AANLkTinKhCG4HauFHrPd=qr9vmVheH59vu2Be=tWoJft@mail.gmail.com>
	<AANLkTik1FY=K1Wuo=vnh5xuq6aS1x2d2Km=ByrCSufJC@mail.gmail.com>
	<AANLkTi=3s6ZRkaBG4uaS=7kaLWD-q2MgN0cN1otBrcmy@mail.gmail.com>
	<AANLkTikG=euGb1f4v50p9xwYtSuZ78aRgJ6XTfxy0TPR@mail.gmail.com>
	<AANLkTintEi=JO222wQARaacpfHPor5usnz-qhNAAFXjm@mail.gmail.com>
	<AANLkTi=RQ3-ZkDKPOByGsey-E45cVA-5Rj3zWOjLutiy@mail.gmail.com>
	<AANLkTik7i9Q9ctdMYno3VcJvcAHpN8g_3KifV+aen9-n@mail.gmail.com>
	<AANLkTim+f5PyGshq5jppzyk=W9t4R8Yw6jxU6VstvH55@mail.gmail.com>
	<AANLkTimjit3ZqwjDDrpw+iBfaq34QAQr0JCDnQuBybGZ@mail.gmail.com>
	<AANLkTinywQZtCpUppZ-2eSqV6s+b+5kDZ6hRVJ36ewgi@mail.gmail.com>
Message-ID: <20110318111258.GK29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 07:03:06AM -0400, Vincent Palatin wrote:
> >> > Just one more question: whats Russell's tree?
> >>
> >> AFAIK: That one :
> >> http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
> >>
> >
> > this does not seem to be a pointer to a valid git repo, or am I missing
> > something?
> 
> The URL is unusual but
> git clone http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
> works for me.
> 
> by the way this server connectivity has limited bandwidth, you would
> rather clone the linus Tree and add this one as another remote :

No it doesn't.  It's very close to the UK backbone.

http://www.arm.linux.org.uk/developer/git-arm.php

That page includes an explaination of the issues, which has more to do
with your internet connectivity and your monthly data allowance than
the server.  Then again, maybe I'm old fashioned and the idea of pulling
450MB to gain a few KB of updates is the in-thing today.
