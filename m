From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Apr 2015 22:35:56 +0100
Subject: [RESEND][PATCH] ARM errata, 430973: update the affected revisions
In-Reply-To: <20150413162808.GZ18048@atomide.com>
References: <1418131842-6752-1-git-send-email-jhofstee@victronenergy.com>
 <54EE2453.9080301@myspectrum.nl> <552840A9.8070406@myspectrum.nl>
 <20150411075220.GK12732@n2100.arm.linux.org.uk>
 <5528E88C.4070107@myspectrum.nl>
 <20150413143941.GY18048@atomide.com>
 <20150413162808.GZ18048@atomide.com>
Message-ID: <20150413213556.GT4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 09:28:09AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150413 07:46]:
> > If what Russell and I are saying is correct, with the above two
> > patches your system should behave properly with 430973 even if
> > bit 6 in the aux ctrl register is set (or unset) by the bootloader.
> > 
> > If r1p7 is behaves with bit 6 cleared and errata 430973 set, then
> > we know r1p7 is unaffected by 430973.
> 
> Sorry let's take this part again:
> 
> If r1p7 is behaves with bit 6 cleared and errata 430973 _unset_,
> then we know r1p7 is unaffected by 430973.

I've asked.  The errata applies to _all_ Cortex A8 r1pX versions.
This is actually what the code in the kernel does today, but the
documentation does not reflect it.  So, I've updated the
documentation to reflect (a) the code and (b) the info I received:

http://ftp.arm.linux.org.uk/cgit/linux-arm.git/commit/?id=59552cc87cb6

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
