From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 17:15:39 +0000
Subject: [BUG] ARM: socfpga: L2 cache init
In-Reply-To: <54F750E6.5030703@opensource.altera.com>
References: <20150209213017.GC7994@pengutronix.de>
 <54DD2BB3.3090507@opensource.altera.com>
 <20150213080106.GD7994@pengutronix.de>
 <CADhT+wfbZb+u7a-aCi71rh9xFMuphOvqiyEgEYpmmTQtujLcVg@mail.gmail.com>
 <20150217222817.GS8656@n2100.arm.linux.org.uk>
 <CADhT+wcpWcfca6JWLAfpQm_yPHOpTRRbCpiikUEs0ha1NHq3TQ@mail.gmail.com>
 <20150225092657.GU8656@n2100.arm.linux.org.uk>
 <CADhT+wcyim0Yeq6Wcy6UFAmv+GPjWtVO3hQQ_7uX1bMskADSJQ@mail.gmail.com>
 <20150304102342.GA14613@pengutronix.de>
 <54F750E6.5030703@opensource.altera.com>
Message-ID: <20150309171539.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 12:37:26PM -0600, Dinh Nguyen wrote:
> On 03/04/2015 04:23 AM, Steffen Trumtrar wrote:
> > Looks good for me, too:
> > 
> > Tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > 
> 
> Steffen, thanks for testing.
> 
> Russell, if you don't mind, I'll take this patch through my tree as I
> have a couple of other fixes for 4.0-rc as well.

That's fine, especially as I've been recovering post-op.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
