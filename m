From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 23 Oct 2015 17:02:09 +0100
Subject: [PATCH] drivers: psci: make PSCI 1.0 functions initialization
 version dependent
In-Reply-To: <7h611xr4on.fsf@deeprootsystems.com>
References: <1445611610-12871-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7h611xr4on.fsf@deeprootsystems.com>
Message-ID: <20151023160209.GB13029@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 08:21:44AM -0700, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

[...]

> > Tested on:
> >
> > - Juno host
> > - AMD Seattle host
> > - kvmtool arm64 guest (on Juno arm64 defconfig host)
> > - Qemu x86 host (aarch64 emulation)
> >
> > A run on kernelci and consequent tested-by tags would be much appreciated,
> > thanks for spotting this and for your help.
> 
> I tested manually on my local qemu that was failing without this patch,
> and it works:
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
> We'll add this onto arm-soc drivers/psci and then it will have a spin through
> kernelci.

Thank you very much !

Lorenzo
