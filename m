From: bzolnier@gmail.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 2 Dec 2009 02:06:59 +0100
Subject: [PATCH] add PATA host controller support for Cirrus Logic's
	EP93xx CPUs
In-Reply-To: <4B15BAA1.2010408@bluewatersys.com>
References: <200911261651.40928.bzolnier@gmail.com>
	<4B15BAA1.2010408@bluewatersys.com>
Message-ID: <200912020206.59659.bzolnier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2009 01:53:53 am Ryan Mallon wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Based on the older IDE host driver by Joao Ramos and review comments
> > for it from Sergei Shtylyov.  Not yet tested with the real hardware.
> >
> 
> Hi Bartlomiej,
> 
> I have got as far as patching this into my kernel and doing a build test
> (still need to find a hard-disk to test). I got some build errors, see
> below:

Hi,

Many thanks for picking this driver up.

The following preparatory libata one-liner is needed to make it build:

	http://patchwork.kernel.org/patch/62926/

and you may also need to update ep93xx ide gpio patch:

	http://thread.gmane.org/gmane.linux.ports.arm.kernel/57688/focus=58730

to current kernels to make the hardware work.

--
Bartlomiej Zolnierkiewicz
