From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 15 Mar 2012 11:44:50 +0100
Subject: Lost fixes?
In-Reply-To: <20120315102845.GB16389@n2100.arm.linux.org.uk>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
Message-ID: <20120315104450.GA20705@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 10:28:45AM +0000, Russell King - ARM Linux wrote:
> These fixes are a collection from other people which resolve various
> issues found with the new kautobuilder.  They're now a month old, and
> as far as I can see, have not been merged into Linus' tree.
> 
> What's the status of them, and when are they going to be merged?
For the drivers/mfd/da9052-spi.c part: A patch from Axel Lin has been living
in my for-next branch for a while now. It's a section mismatch warning fix, so
not something I consider worth sending to Linus after the merge window is
closed. So it's queued for the next one.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
