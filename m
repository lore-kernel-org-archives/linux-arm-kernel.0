From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 17 Apr 2017 22:09:56 +0200 (CEST)
Subject: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
In-Reply-To: <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
 <20170403154829.29780-2-zajec5@gmail.com>
 <20170407044218.GA12447@localhost.localdomain>
 <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
Message-ID: <1653958941.84030.1492459796937@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Rafa? Mi?ecki <rafal@milecki.pl> hat am 14. April 2017 um 14:16 geschrieben:
> 
> 
> On 04/07/2017 06:42 AM, Eduardo Valentin wrote:
> > On Mon, Apr 03, 2017 at 05:48:29PM +0200, Rafa? Mi?ecki wrote:
> >> From: Rafa? Mi?ecki <rafal@milecki.pl>
> >>
> >> Northstar is a SoC family commonly used in home routers. This commit
> >> adds a driver for checking CPU temperature. As Northstar Plus seems to
> >> also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.
> >>
> >> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> >> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> >
> > If no objection, I am applying this series.
> 
> Cool, hopefully there aren't any more objections :) Once applied should I
> expect this in
> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=next
> ?
> 
> That would allow me to move bcm2835_thermal.c to the broadcom subdir.

Thanks for doing this. Btw Northstar thermal driver misses a MODULE_AUTHOR.

Regards
Stefan
