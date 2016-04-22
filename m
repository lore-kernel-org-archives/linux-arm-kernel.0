From: sstabellini@kernel.org (Stefano Stabellini)
Date: Fri, 22 Apr 2016 12:57:41 +0100 (BST)
Subject: [PATCH v11 15/17] ARM64: XEN: Add a function to initialize Xen
 specific UEFI runtime services
In-Reply-To: <20160422105427.GG2998@e104818-lin.cambridge.arm.com>
References: <1460030614-16112-1-git-send-email-zhaoshenglong@huawei.com>
 <1460030614-16112-16-git-send-email-zhaoshenglong@huawei.com>
 <20160422105427.GG2998@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.10.1604221257150.6744@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2016, Catalin Marinas wrote:
> On Thu, Apr 07, 2016 at 08:03:32PM +0800, Shannon Zhao wrote:
> > From: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > When running on Xen hypervisor, runtime services are supported through
> > hypercall. Add a Xen specific function to initialize runtime services.
> > 
> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  arch/arm/include/asm/xen/xen-ops.h   |  6 ++++++
> >  arch/arm/xen/Makefile                |  1 +
> >  arch/arm/xen/efi.c                   | 40 ++++++++++++++++++++++++++++++++++++
> >  arch/arm64/include/asm/xen/xen-ops.h |  6 ++++++
> >  arch/arm64/xen/Makefile              |  1 +
> >  drivers/xen/Kconfig                  |  2 +-
> >  6 files changed, 55 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/include/asm/xen/xen-ops.h
> >  create mode 100644 arch/arm/xen/efi.c
> >  create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
> 
> This looks like entirely Xen code, so I don't think it needs arm64
> maintainers' approval. FWIW:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks Catalin, I'll go ahead and queue the series up for 4.7.

Cheers,

Stefano
