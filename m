From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 16:17:33 +0100
Subject: [PATCH v14 0/9] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20161020145752.GC8731@red-moon>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <20161020143101.GI10234@leverpostej>
 <20161020145752.GC8731@red-moon>
Message-ID: <20161020151655.GA27598@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 03:57:52PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Oct 20, 2016 at 03:31:01PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > On Thu, Sep 29, 2016 at 02:17:08AM +0800, fu.wei at linaro.org wrote:
> > > From: Fu Wei <fu.wei@linaro.org>
> > 
> > > This patchset depends on the following patchset:
> > > [UPDATE PATCH V11 1/8] ACPI: I/O Remapping Table (IORT) initial support
> > > https://lkml.org/lkml/2016/9/12/949
> > 
> > Is there a branch with these anywhere? I wasn't Cc'd on those and it's
> > rather difficult to get at the series from an LKML link.
> 
> For the records, the dependency above has now been merged and it was
> just a directory creation dependency (drivers/acpi/arm64, where some of
> the code in this series will live).

Ah, I see. That saves us all some trouble, then. :)

Thanks,
Mark.
