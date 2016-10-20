From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Oct 2016 15:57:52 +0100
Subject: [PATCH v14 0/9] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20161020143101.GI10234@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <20161020143101.GI10234@leverpostej>
Message-ID: <20161020145752.GC8731@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 03:31:01PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Thu, Sep 29, 2016 at 02:17:08AM +0800, fu.wei at linaro.org wrote:
> > From: Fu Wei <fu.wei@linaro.org>
> 
> > This patchset depends on the following patchset:
> > [UPDATE PATCH V11 1/8] ACPI: I/O Remapping Table (IORT) initial support
> > https://lkml.org/lkml/2016/9/12/949
> 
> Is there a branch with these anywhere? I wasn't Cc'd on those and it's
> rather difficult to get at the series from an LKML link.

For the records, the dependency above has now been merged and it was
just a directory creation dependency (drivers/acpi/arm64, where some of
the code in this series will live). So basically this means that at
present this series is self-contained, probably it would have been
better to wait for -rc1 before posting it (so that dependencies were
settled) but anyway I think it can be reviewed as-is.

Thanks for having a look,
Lorenzo
