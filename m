From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 25 Sep 2017 11:18:08 -0700
Subject: [PATCH v3 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <1623.1506353803@warthog.procyon.org.uk>
References: <20170922075807.GM17186@linaro.org>
 <20170915105932.25338-1-takahiro.akashi@linaro.org>
 <20170915105932.25338-4-takahiro.akashi@linaro.org>
 <20170921073516.GA6643@dhcp-128-65.nay.redhat.com>
 <1623.1506353803@warthog.procyon.org.uk>
Message-ID: <20170925181806.kd567i4xpquueqw5@dragonfly>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 04:36:43PM +0100, David Howells wrote:
> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> 
> > > > -static struct kexec_file_ops *kexec_file_loaders[] = {
> > > > +struct kexec_file_ops *kexec_file_loaders[] = {
> > > >  	&kexec_elf64_ops,
> > > > +	NULL
> > > >  };
> 
> const?

Yes, it makes sense.

-Takahiro AKASHI

> 
> David
