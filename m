From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jun 2012 15:32:49 +0100
Subject: [PATCH] ARM: two possible fixes for the KALLSYMS build problem
In-Reply-To: <20120611203748.GA16967@codeaurora.org>
References: <1338567721-19514-1-git-send-email-davidb@codeaurora.org>
 <20120611203748.GA16967@codeaurora.org>
Message-ID: <20120612143249.GB7918@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 01:37:48PM -0700, David Brown wrote:
> On Fri, Jun 01, 2012 at 09:21:59AM -0700, David Brown wrote:
> 
> > David Brown (1):
> >   ARM: Prevent KALLSYM size mismatch on ARM.
> > 
> >  arch/arm/kernel/vmlinux.lds.S |    3 +++
> >  1 file changed, 3 insertions(+)
> 
> Just wondering if anyone has had a chance to look at either of these,
> or try them.  I haven't seen any KALLSYMS mismatch build errors with
> either of these patches applied.

I think variant 2 is the better approach out of either as it doesn't add
to the size of the resulting kernel image.
