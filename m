From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jul 2011 21:07:31 +0100
Subject: [PATCH v2] ARM: support XZ compressed kernels
In-Reply-To: <op.vy1dpjip2s3iss@ecaz>
References: <1310475369-3000-1-git-send-email-kaloz@openwrt.org>
	<20110715162519.GC24628@n2100.arm.linux.org.uk>
	<op.vyptiwow2s3iss@ecaz>
	<20110719110235.GH26574@n2100.arm.linux.org.uk>
	<20110719110717.GI26574@n2100.arm.linux.org.uk>
	<20110722091604.GC21416@n2100.arm.linux.org.uk>
	<op.vy0lphg52s3iss@ecaz>
	<20110722095738.GE21416@n2100.arm.linux.org.uk>
	<20110722125036.GG21416@n2100.arm.linux.org.uk>
	<op.vy1dpjip2s3iss@ecaz>
Message-ID: <20110722200731.GH25947@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 09:57:09PM +0200, Imre Kaloz wrote:
> I've already proposed the right way to fix it in http://lists.arm.linux.org.uk/lurker/message/20110722.102718.6e9fe66c.en.html

I think you're missing the point.

So, as I've already said I've dropped your original patch, and I'm now
talking directly to Lasse about how best to resolve this (which IMHO is
what should've already happened.)  If Lasse doesn't want to fix it in his
code then we'll see about modifying ARM specific stuff.

As you've already pointed out, the code uses min_t, but doesn't contain
an include of linux/kernel.h - so maybe its also broken on other arches.

Until it's discussed, we won't know.
