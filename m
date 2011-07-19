From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2011 12:07:17 +0100
Subject: [PATCH v2] ARM: support XZ compressed kernels
In-Reply-To: <20110719110235.GH26574@n2100.arm.linux.org.uk>
References: <1310475369-3000-1-git-send-email-kaloz@openwrt.org>
	<20110715162519.GC24628@n2100.arm.linux.org.uk>
	<op.vyptiwow2s3iss@ecaz>
	<20110719110235.GH26574@n2100.arm.linux.org.uk>
Message-ID: <20110719110717.GI26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 12:02:35PM +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 16, 2011 at 04:07:34PM +0200, Imre Kaloz wrote:
> > On Fri, 15 Jul 2011 18:25:19 +0200, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> >
> >> On Tue, Jul 12, 2011 at 02:56:09PM +0200, Imre Kaloz wrote:
> >>> Wire up support for the XZ decompressor
> >>
> >> Ok.
> >
> > Thanks, added to the patch system.
> 
> FYI:
> 
> Patching 7001/1...
> <stdin>:56: space before tab in indent.
>                 $(addprefix $(obj)/, $(OBJS)) $(lib1funcs) $(ashldi3) FORCE
> warning: 1 line applied after fixing whitespace errors.

BTW, has anyone outside of the ARM community seen the patch to
lib/xz/xz_dec_stream.c adding the linux/kernel.h include?  How
well tested is that change on other architectures?
