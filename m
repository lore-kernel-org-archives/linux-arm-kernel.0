From: ijc@debian.org (Ian Campbell)
Date: Wed, 06 May 2015 09:01:12 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure
 drivers for both Cubox i4pro real time clocks
In-Reply-To: <1430583695.15640.190.camel@hellion.org.uk>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
 <1430582464.15640.186.camel@hellion.org.uk>
 <20150502161226.GS12732@n2100.arm.linux.org.uk>
 <1430583695.15640.190.camel@hellion.org.uk>
Message-ID: <1430899272.15640.237.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-05-02 at 17:21 +0100, Ian Campbell wrote:
> We typically build RTCs statically (for this sort of reason) so it seems
> like the right thing for us to do here is to build both in.

Which I've now done in SVN. Rick, please test the next upload.

Also, Rick, I'm getting messages from my MTA about not being able to
deliver to rbthomas at cube.rcthomas.org, it's been queuing/retrying since
the weekend and says I shouldn't worry, but I thought I'd mention it
since I was here. Exim logs say:

2015-05-06 06:48:50 1YoZqj-0002JC-G0 == rbthomas at cube.rcthomas.org R=dnslookup T=remote_smtp defer (-53): retry time not reached for any host

Hopefully you will see this via some other route.

Ian.
