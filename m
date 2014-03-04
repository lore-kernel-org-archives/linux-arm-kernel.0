From: graeme@xora.org.uk (Graeme Gregory)
Date: Wed, 5 Mar 2014 03:03:18 +0800
Subject: [PATCH] MAINTAINERS: add maintainers for arm64 acpi
In-Reply-To: <20140304102316.GG30596@arm.com>
References: <1393899345-7397-1-git-send-email-graeme.gregory@linaro.org>
 <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
 <20140304102316.GG30596@arm.com>
Message-ID: <20140304190318.GE28736@xora-yoga13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 10:23:16AM +0000, Catalin Marinas wrote:
> On Tue, Mar 04, 2014 at 02:15:45AM +0000, Graeme Gregory wrote:
> > +ACPI ARM64
> 
> That's a pretty broad statement for a single file. Is it core support,
> architected peripherals, SoC?
> 
Hi Catalin would changing the title to ACPI ARM64 Core Support be better
in your mind. I do intend for the maintainership to cover just the
plat/arm-core.c file.

Graeme

> > +M:	Hanjun Guo <hanjun.guo@linaro.org>
> > +M:	Graeme Gregory <graeme.gregory@linaro.org>
> > +S:	Supported
> > +L:	linux-acpi at vger.kernel.org
> > +F:	drivers/acpi/plat/arm-core.c
> 
> This patch should be part of the series introducing the arm-core.c file
> and it will be ACKed (or NAKed) following review. We can't really commit
> maintainers to a file which does not exist in mainline and while there is
> still feedback to be addressed. It's like a blank cheque.
> 
> -- 
> Catalin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
