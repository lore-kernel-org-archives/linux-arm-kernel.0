From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Apr 2015 17:21:39 +0100
Subject: [PATCH 0/7] Fix Keystone 2 physical address switch
In-Reply-To: <552563AB.8050308@oracle.com>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <552563AB.8050308@oracle.com>
Message-ID: <20150409162139.GZ12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 10:21:47AM -0700, santosh shilimkar wrote:
> Russell,
> 
> On 4/8/2015 2:44 AM, Russell King - ARM Linux wrote:
> >For some time, the Keystone 2 physical address switch has been
> >tainting the kernel ever since we decided that it was not safe.
> >
> >This series re-works the address switch to be compliant architecturally.
> >
> Thanks a lot for doing it. Will have a look at the series.

I think given where we are, it's already too late to get it into this
merge window _unless_ Linus does -rc8 this weekend.  I don't classify
this as a "fix" which would be mergable during the window or during
-rc after, but more as a correctness update.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
