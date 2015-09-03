From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2015 09:05:02 +0100
Subject: Cortex A9 MP: ARM errata 754323 implementation?
In-Reply-To: <55E7F965.8080802@de.bosch.com>
References: <55E7F965.8080802@de.bosch.com>
Message-ID: <20150903080502.GT21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 09:40:21AM +0200, Dirk Behme wrote:
> looking through the ARM Cortex A9 errata list [1] I wonder why we don't have
> a workaround for
> 
> (754323) Repeated Store in the same cache line might delay the visibility of
> the Store
> 
> in the kernel? Or have I missed it?

The policy for errata is not to implement them unless there's a requirement
to do so - and then the errata should be implemented in board firmware in
preference to the kernel where possible.

Are you seeing a problem directly attributable to this errata?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
