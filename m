From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 30 Jun 2017 19:55:11 -0700
Subject: [PATCH v2] thermal: bcm2835: Fix error code in
 'bcm2835_thermal_probe'
In-Reply-To: <1667598657.325840.1498249545131@email.1und1.de>
References: <20170623194435.8094-1-christophe.jaillet@wanadoo.fr>
 <1667598657.325840.1498249545131@email.1und1.de>
Message-ID: <20170701025509.GB11217@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 10:25:45PM +0200, Stefan Wahren wrote:
> 
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> hat am 23. Juni 2017 um 21:44 geschrieben:
> > 
> > 
> > 'tz' is a valid pointer at this point, so calling PTR_ERR on it is
> > pointless.
> > This 'err = PTR_ERR(tz)' looks like a cut'n'paste from a few lines above.
> > So remove it. 'err' is already the error we want to report.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks, but Dan Carpenter already send a fix for this.

Yeah, and I applied Dan's version as it was coming first in my queue. Sorry.
