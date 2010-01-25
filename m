From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Jan 2010 10:57:14 +0000
Subject: Default machine include placements
In-Reply-To: <20100125104425.GO26562@trinity.fluff.org>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
Message-ID: <20100125105713.GA22909@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 10:44:25AM +0000, Ben Dooks wrote:

> Not sure how git deals with symlinks, and I think this will just leave
> us a mess on systems that don't really understand symlinks.

Given that the kernel already includes a number of files distinguished
only by case I'm not sure that that is such a concern - the kernel is
already causing troubles for older filesystems anyway.
