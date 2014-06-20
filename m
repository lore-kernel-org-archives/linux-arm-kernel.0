From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 20 Jun 2014 11:57:59 +0300
Subject: v3.16-rc1 & default cachepolicy
In-Reply-To: <20140619233626.GI3705@n2100.arm.linux.org.uk>
References: <20140619203655.GE558@drone.musicnaut.iki.fi>
 <20140619205853.GH3705@n2100.arm.linux.org.uk>
 <20140619224004.GF558@drone.musicnaut.iki.fi>
 <20140619233626.GI3705@n2100.arm.linux.org.uk>
Message-ID: <20140620085759.GG558@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 20, 2014 at 12:36:26AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 20, 2014 at 01:40:04AM +0300, Aaro Koskinen wrote:
> > So I tried the below change. But now it hangs early, even before
> > the earlyprintk is working. :-/
> 
> Thanks for trying.  I notice you said "write-through", so can you
> drop the PMD_SECT_BUFFERABLE flag and try again please?

Yes, that works.

A.
