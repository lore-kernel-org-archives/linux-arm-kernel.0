From: matt@console-pimps.org (Matt Fleming)
Date: Fri, 23 May 2014 14:24:57 +0100
Subject: EFI_STUB fails to boot non-EFI on arm64
In-Reply-To: <20140523131656.GR4179@bivouac.eciton.net>
References: <20140523094513.GC9252@arm.com>
 <20140523131656.GR4179@bivouac.eciton.net>
Message-ID: <20140523132457.GA23963@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 May, at 02:16:56PM, Leif Lindholm wrote:
> On Fri, May 23, 2014 at 10:45:13AM +0100, Catalin Marinas wrote:
> > As the EFI_STUB for arm64 got into tip and soon into -next, I thought
> > about giving it a try (tip/arm64/efi). Using my boot-wrapper (non-EFI)
> > is still supposed to work but I get the trace below. It looks like
> > memmap.map is NULL but the code still assumes the kernel was started as
> > an EFI app.
> > 
> > Have you guys tested these patches properly?
> 
> Apparently not sufficuently...
> Sorry about that.
> 
> Fix appended:

This looks pretty straight forward. I've picked it up and shoved it on
my arm64-efi branch.

-- 
Matt Fleming, Intel Open Source Technology Center
