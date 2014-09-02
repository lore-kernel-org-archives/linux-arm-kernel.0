From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Sep 2014 17:34:14 +0100
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <5405AE95.1020201@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
 <5404AE56.80801@arm.com> <5405AE95.1020201@linaro.org>
Message-ID: <20140902163414.GJ27056@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 12:48:37PM +0100, Tomasz Nowicki wrote:
> On 01.09.2014 19:35, Marc Zyngier wrote:
> > On 01/09/14 15:57, Hanjun Guo wrote:
> >> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >>
> >> ACPI kernel uses MADT table for proper GIC initialization. It needs to
> >> parse GIC related subtables, collect CPU interface and distributor
> >> addresses and call driver initialization function (which is hardware
> >> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> >>
> >> NOTE: This commit allow to initialize GICv1/2 only.
> >
> > I cannot help but notice that there is no support for KVM here. It'd be
> > good to add a note to that effect, so that people do not expect
> > virtualization support to be working when booting with ACPI.
> 
> yes, it is worth mentioning!

It's also worth mentioning if there are any plans to fix this ;).

-- 
Catalin
