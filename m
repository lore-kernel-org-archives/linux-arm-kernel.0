From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 8 Sep 2017 11:31:17 +0900
Subject: [PATCH 05/14] kexec_file: factor out crashdump elf header
 function from x86
In-Reply-To: <20170825054749.GA8604@dhcp-128-65.nay.redhat.com>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-6-takahiro.akashi@linaro.org>
 <20170825054749.GA8604@dhcp-128-65.nay.redhat.com>
Message-ID: <20170908023115.GA17186@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 01:47:49PM +0800, Dave Young wrote:
> On 08/24/17 at 05:18pm, AKASHI Takahiro wrote:
> > prepare_elf_headers() can also be useful for other architectures,
> > including arm64. So let it factored out.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/kernel/crash.c | 324 ----------------------------------------------
> >  include/linux/kexec.h   |  19 +++
> >  kernel/crash_core.c     | 333 ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> It looks better to add these to kexec_file.c instead.

Sure

-Takahiro AKASHI

> Thanks
> Dave
