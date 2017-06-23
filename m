From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 23 Jun 2017 22:25:45 +0200 (CEST)
Subject: [PATCH v2] thermal: bcm2835: Fix error code in
 'bcm2835_thermal_probe'
In-Reply-To: <20170623194435.8094-1-christophe.jaillet@wanadoo.fr>
References: <20170623194435.8094-1-christophe.jaillet@wanadoo.fr>
Message-ID: <1667598657.325840.1498249545131@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Christophe JAILLET <christophe.jaillet@wanadoo.fr> hat am 23. Juni 2017 um 21:44 geschrieben:
> 
> 
> 'tz' is a valid pointer at this point, so calling PTR_ERR on it is
> pointless.
> This 'err = PTR_ERR(tz)' looks like a cut'n'paste from a few lines above.
> So remove it. 'err' is already the error we want to report.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, but Dan Carpenter already send a fix for this.
