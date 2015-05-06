From: ijc@debian.org (Ian Campbell)
Date: Wed, 06 May 2015 11:27:03 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure
 drivers for both Cubox i4pro real time clocks
In-Reply-To: <64A51823-C50B-48D5-8180-CBC44F691CCB@pobox.com>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
 <1430582464.15640.186.camel@hellion.org.uk>
 <20150502161226.GS12732@n2100.arm.linux.org.uk>
 <1430583695.15640.190.camel@hellion.org.uk>
 <1430899272.15640.237.camel@debian.org>
 <64A51823-C50B-48D5-8180-CBC44F691CCB@pobox.com>
Message-ID: <1430908023.2660.203.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control: submitter -1 Rick Thomas <rbthomas@pobox.com>

On Wed, 2015-05-06 at 03:00 -0700, Rick Thomas wrote:
> OK, How will I identify the upload when I see it?  The box is running
> Debian/Sid and I do regular updates.  So presumably, I?ll see a
> ?linux-image-3.16.0-4-armmp? package go by sometime soon?

I think the next thing to hit Sid will be some 4.0.x per
https://lists.debian.org/debian-kernel/2015/05/msg00047.html

I also committed to the Jessie branch so eventually (I don't know when)
a new 3.16 based thing should appear in jessie-proposed-updates (staging
area for a point release). I'm not sure if the BTS will say anything
when this happens nor how else one might get notified.

It would be preferable to test the thing in Sid before the upload to
jessie-proposed-updates

> And I?ll know I?ve got it when I see two /dev/rtc* devices?

Yes, I suppose.

> As for ?rbthomas at cube.rcthomas.org? ? I?m afraid it?s bogus.  I had
> exim4 configured wrong when I submitted the original bugreport  /-:.
> I?m subscribed to the bugreport with my proper address
> (?rbthomas at pobox.com?) now; so you can either just send stuff for me
> to the bugreport directly or to the ?@pobox.com? address, and delete
> (or simply ignore) ?rbthomas at cube.rcthomas.org? whenever it raises its
> head.

I think the line at the top should have reset the submitter to your
proper address too. If you wanted to do that yourself you could use "!"
as a shorthand for the address in the From: line.

Ian.
