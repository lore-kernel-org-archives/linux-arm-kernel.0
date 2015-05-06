From: rbthomas@pobox.com (Rick Thomas)
Date: Wed, 6 May 2015 03:00:30 -0700
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure drivers
 for both Cubox i4pro real time clocks
In-Reply-To: <1430899272.15640.237.camel@debian.org>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
 <1430582464.15640.186.camel@hellion.org.uk>
 <20150502161226.GS12732@n2100.arm.linux.org.uk>
 <1430583695.15640.190.camel@hellion.org.uk>
 <1430899272.15640.237.camel@debian.org>
Message-ID: <64A51823-C50B-48D5-8180-CBC44F691CCB@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, How will I identify the upload when I see it?  The box is running Debian/Sid and I do regular updates.  So presumably, I?ll see a ?linux-image-3.16.0-4-armmp? package go by sometime soon?  And I?ll know I?ve got it when I see two /dev/rtc* devices?

As for ?rbthomas at cube.rcthomas.org? ? I?m afraid it?s bogus.  I had exim4 configured wrong when I submitted the original bugreport  /-:.  I?m subscribed to the bugreport with my proper address (?rbthomas at pobox.com?) now; so you can either just send stuff for me to the bugreport directly or to the ?@pobox.com? address, and delete (or simply ignore) ?rbthomas at cube.rcthomas.org? whenever it raises its head.

Thanks!  This has been an interesting and educational discussion!
Rick


On May 6, 2015, at 1:01 AM, Ian Campbell <ijc@debian.org> wrote:

> On Sat, 2015-05-02 at 17:21 +0100, Ian Campbell wrote:
>> We typically build RTCs statically (for this sort of reason) so it seems
>> like the right thing for us to do here is to build both in.
> 
> Which I've now done in SVN. Rick, please test the next upload.
> 
> Also, Rick, I'm getting messages from my MTA about not being able to
> deliver to rbthomas at cube.rcthomas.org, it's been queuing/retrying since
> the weekend and says I shouldn't worry, but I thought I'd mention it
> since I was here. Exim logs say:
> 
> 2015-05-06 06:48:50 1YoZqj-0002JC-G0 == rbthomas at cube.rcthomas.org R=dnslookup T=remote_smtp defer (-53): retry time not reached for any host
> 
> Hopefully you will see this via some other route.
> 
> Ian.
> 
> -- 
> To unsubscribe, send mail to 782364-unsubscribe at bugs.debian.org.
> 
