From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 15:01:02 +0000
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <20110118144452.GB13576@shutemov.name>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<20110118143041.GA13576@shutemov.name>
	<20110118144014.GE10997@n2100.arm.linux.org.uk>
	<20110118144452.GB13576@shutemov.name>
Message-ID: <20110118150102.GF10997@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 04:44:52PM +0200, Kirill A. Shutemov wrote:
> On Tue, Jan 18, 2011 at 02:40:14PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 18, 2011 at 04:30:41PM +0200, Kirill A. Shutemov wrote:
> > > On Mon, Jan 17, 2011 at 07:20:50PM +0000, Russell King - ARM Linux wrote:
> > > > This patch series reworks the ARMv6/ARMv6K support options, code
> > > > selection, and bit operations such that it's possible to safely
> > > > build a kernel which supports ARMv6, ARMv6K, ARMv7 and ARMv7 SMP
> > > > in one image.
> > > 
> > > Is it posible to implement CPU_ARCH_ARMv6K as well for runtime checks?
> > 
> > Err what?  There's no CPU_ARCH_ARMv6K.
> 
> I some cases we need runtime check for K extention (see exceptions_init())
> Is there any facility for it?
