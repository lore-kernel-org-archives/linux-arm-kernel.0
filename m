From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 10 Dec 2010 17:54:15 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <20101210165021.GA28263@n2100.arm.linux.org.uk>
References: <1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
	<1291975704.6803.59.camel@twins> <1291987065.6803.151.camel@twins>
	<1291987635.6803.161.camel@twins> <1291988866.6803.171.camel@twins>
	<20101210165021.GA28263@n2100.arm.linux.org.uk>
Message-ID: <1292000055.13513.26.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-12-10 at 16:50 +0000, Russell King - ARM Linux wrote:
> > Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> I think credit should go to Mikael Pettersson, who identified the
> interactivity regression and problematical commit.  I only pointed
> out the dubious nature of the code. 

Ah, thanks, missed that. Updated the patch.
