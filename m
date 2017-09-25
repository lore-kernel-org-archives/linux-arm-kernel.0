From: dhowells@redhat.com (David Howells)
Date: Mon, 25 Sep 2017 16:36:43 +0100
Subject: [PATCH v3 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <20170922075807.GM17186@linaro.org>
References: <20170922075807.GM17186@linaro.org>
 <20170915105932.25338-1-takahiro.akashi@linaro.org>
 <20170915105932.25338-4-takahiro.akashi@linaro.org>
 <20170921073516.GA6643@dhcp-128-65.nay.redhat.com>
Message-ID: <1623.1506353803@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> > > -static struct kexec_file_ops *kexec_file_loaders[] = {
> > > +struct kexec_file_ops *kexec_file_loaders[] = {
> > >  	&kexec_elf64_ops,
> > > +	NULL
> > >  };

const?

David
