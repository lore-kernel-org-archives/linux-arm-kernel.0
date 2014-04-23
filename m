From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Apr 2014 19:21:27 +0100
Subject: [PATCH] ARM: prima2: remove L2 cache size override
In-Reply-To: <20140416092433.GG24070@n2100.arm.linux.org.uk>
References: <1397555342-25644-1-git-send-email-21cnbao@gmail.com>
 <20140416092433.GG24070@n2100.arm.linux.org.uk>
Message-ID: <20140423182127.GJ24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 10:24:33AM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 15, 2014 at 05:49:02PM +0800, Barry Song wrote:
> > +static __init void sirfsoc_init_mach(void)
> > +{
> > +	l2x0_of_init(0, 0xFDFFFFFFUL);
> 
> BTW, this should be just the plain: 0xfdffffff - no need for UL on the
> end.  Also lower case is preferred for hex.

So... I provide feedback, and nothing happens.

FYI, tonight, I'm pushing out my L2C branch into linux-next with the
original patch for prima2 incorporated, as my concerns against your
patch have not been addressed.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
