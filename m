From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 12:25:42 +0100
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <20120413104900.GM24211@n2100.arm.linux.org.uk>
References: <20120413012230.GA30438@windriver.com>
 <CAAQ0ZWReL=+bm9UOnt2=Dfy0zeWbJe3=y3pPzUKRzm2y277kFQ@mail.gmail.com>
 <20120413103207.GL24211@n2100.arm.linux.org.uk>
 <20120413104452.GR3168@opensource.wolfsonmicro.com>
 <20120413104900.GM24211@n2100.arm.linux.org.uk>
Message-ID: <20120413112539.GS3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 11:49:00AM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 13, 2012 at 11:44:52AM +0100, Mark Brown wrote:

> > I did say we should've been pushing Shawn's patch in as a minimal fix
> > for 3.4...

> What patch?

The original one which just changed the return code that's checked for.

> > Regardless of what happens for 3.4 we should keep the removal for -next,
> > it's clear that we don't want the bus doing this and it's causing
> > breakage for the non-ST platforms.  Do I need to resend the patch to the
> > patch system or will the existing copy be OK?

> What I want is something that doesn't cause a regression for 3.4.

Well, if the overall result is something other than removing the code in
3.5 then we'll just get further regressions down the line.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/f4fac225/attachment.sig>
