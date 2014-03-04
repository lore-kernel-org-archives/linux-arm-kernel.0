From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Mar 2014 10:23:16 +0000
Subject: [PATCH] MAINTAINERS: add maintainers for arm64 acpi
In-Reply-To: <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
References: <1393899345-7397-1-git-send-email-graeme.gregory@linaro.org>
 <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
Message-ID: <20140304102316.GG30596@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 02:15:45AM +0000, Graeme Gregory wrote:
> +ACPI ARM64

That's a pretty broad statement for a single file. Is it core support,
architected peripherals, SoC?

> +M:	Hanjun Guo <hanjun.guo@linaro.org>
> +M:	Graeme Gregory <graeme.gregory@linaro.org>
> +S:	Supported
> +L:	linux-acpi at vger.kernel.org
> +F:	drivers/acpi/plat/arm-core.c

This patch should be part of the series introducing the arm-core.c file
and it will be ACKed (or NAKed) following review. We can't really commit
maintainers to a file which does not exist in mainline and while there is
still feedback to be addressed. It's like a blank cheque.

-- 
Catalin
