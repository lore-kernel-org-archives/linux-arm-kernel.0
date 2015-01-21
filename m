From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jan 2015 16:46:41 +0000
Subject: unclear ipv6 redirect message (was Re: [PATCH v3 2/3] mfd:
 lubbock_io: add lubbock_io board)
In-Reply-To: <1421858444.10574.14.camel@perches.com>
References: <1421406010-14851-2-git-send-email-robert.jarzmik@free.fr>
 <20150119091705.GG21886@x1> <87ppaah9k5.fsf@free.fr>
 <20150120102919.GP5767@x1>
 <20150120115658.GJ26493@n2100.arm.linux.org.uk>
 <873874fuei.fsf@free.fr>
 <20150121094453.GO26493@n2100.arm.linux.org.uk>
 <1421856321.10574.13.camel@perches.com>
 <20150121161059.GT26493@n2100.arm.linux.org.uk>
 <1421858444.10574.14.camel@perches.com>
Message-ID: <20150121164641.GU26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 08:40:44AM -0800, Joe Perches wrote:
> On Wed, 2015-01-21 at 16:11 +0000, Russell King - ARM Linux wrote:
> > On Wed, Jan 21, 2015 at 08:05:21AM -0800, Joe Perches wrote:
> > > (adding netdev)
> > 
> > I wasn't actually reporting that as an issue; I was using it as an
> > example.  It's from a very old kernel (2.6.27.21) which I run on one
> > of my old x86 machines.
> 
> It's still the same code.
> If the message can be improved, why not do it?

I assume you're taking the responsibility to test anything that comes
out of this then?

I'm not; I tried updating the kernel on the machine to 2.6.32 many
years ago and that was a no-go because of userspace (udev)
incompatibilities.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
