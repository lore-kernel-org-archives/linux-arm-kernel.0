From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 18 Apr 2016 10:07:08 +0100
Subject: [PATCH v3] ARM64: ACPI: Update documentation for latest
 specification version
In-Reply-To: <57112AC0.2050607@linaro.org>
References: <1459210002-3387-1-git-send-email-al.stone@linaro.org>
 <20160415143719.GA8798@red-moon> <5711199E.9010508@linaro.org>
 <20160415174716.GB10014@red-moon> <57112AC0.2050607@linaro.org>
Message-ID: <20160418090708.GA2427@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 11:54:08AM -0600, Al Stone wrote:

[...]

> > Understood, the point I wanted to make is that adding a list of methods
> > in acpi_object_usage.txt ("Use as needed") is not necessarily additional
> > information, you can add a pointer at ACPI specs (for that specific
> > purpose - as I said there are parts of the patch that add additional
> > information Linux related) for that purpose instead of having to list
> > all of them in acpi_object_usage.txt again.
> 
> I see.  That makes sense.  How about I collapse those down with something
> on the order of "unless otherwise noted, use as needed" and just remove the
> ones that have no specific info?

Agreed, that would also help you avoid keeping track of new specs
updates that do not necessarily require updates to these docs.

Lorenzo
