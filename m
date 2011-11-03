From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 3 Nov 2011 19:12:28 -0400
Subject: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
In-Reply-To: <201111031907.46434.vapier@gentoo.org>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
	<20111103224452.GS12913@n2100.arm.linux.org.uk>
	<201111031907.46434.vapier@gentoo.org>
Message-ID: <201111031912.33040.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 November 2011 19:07:42 Mike Frysinger wrote:
> i'm aware of these efforts, but i don't see how this Kconfig solution gets
> you there.  it's still a single define depending on arch-specific knobs. 
> now, if this were treated as a max value that was based on all the arch
> needs, it's now useful across SoCs.

s/arch/mach/g
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111103/9386bc9b/attachment.sig>
