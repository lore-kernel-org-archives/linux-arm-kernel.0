From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 19:27:30 +0100
Subject: [PATCH] efi/arm64: store Runtime Services revision
In-Reply-To: <20140826182450.GA28116@console-pimps.org>
References: <1408028122-1784-1-git-send-email-semen.protsenko@linaro.org>
 <20140826090533.GA3193@arm.com>
 <20140826182450.GA28116@console-pimps.org>
Message-ID: <20140826182729.GJ23445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 07:24:50PM +0100, Matt Fleming wrote:
> On Tue, 26 Aug, at 10:05:33AM, Will Deacon wrote:
> > 
> > I doubt it makes any difference, but can we assign this before we call
> > efi_native_runtime_setup please?
> 
> This would have to be a follow up patch, v2 of this patch is already in
> Linus' tree as commit 6a7519e81321.

Ah, ok, I wouldn't worry about it then. I was just trawling the list for
arm64 patches without me on CC in case I missed anything during the kernel
summit.

Thanks for picking it up!

Will
