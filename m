From: stepanm@codeaurora.org (stepanm at codeaurora.org)
Date: Tue, 10 Aug 2010 12:22:08 -0700 (PDT)
Subject: [PATCH v3] arm: msm: Add MSM IOMMU support.
In-Reply-To: <1281418597.1954.106.camel@Joe-Laptop.home>
References: <1281407259-28626-1-git-send-email-stepanm@codeaurora.org>
	<1281409689.1954.96.camel@Joe-Laptop.home>
	<bf2b5539fdb03a1a9c55ee1122c40b99.squirrel@www.codeaurora.org>
	<1281418597.1954.106.camel@Joe-Laptop.home>
Message-ID: <821ba2d399d553ea5f0398ef7b94e464.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, 2010-08-09 at 20:42 -0700, stepanm at codeaurora.org wrote:
> I believe the current uses of pr_err in this module
> are unnecessary or could be converted to pr_debug.
>
> I think __func__/line aren't particularly useful.
>
> I prefer log messages prefixed with the module name.
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> and I'd convert all the current pr_err to pr_debug
> and convert the printk(KERN_ERR to pr_err(
>
> cheers, Joe

Thanks. Fixed in v4, which will go up in a few minutes.
