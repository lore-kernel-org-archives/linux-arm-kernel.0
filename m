From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jun 2014 00:36:26 +0100
Subject: v3.16-rc1 & default cachepolicy
In-Reply-To: <20140619224004.GF558@drone.musicnaut.iki.fi>
References: <20140619203655.GE558@drone.musicnaut.iki.fi>
 <20140619205853.GH3705@n2100.arm.linux.org.uk>
 <20140619224004.GF558@drone.musicnaut.iki.fi>
Message-ID: <20140619233626.GI3705@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 01:40:04AM +0300, Aaro Koskinen wrote:
> So I tried the below change. But now it hangs early, even before
> the earlyprintk is working. :-/

Thanks for trying.  I notice you said "write-through", so can you
drop the PMD_SECT_BUFFERABLE flag and try again please?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
