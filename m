From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed, 17 Nov 2010 12:52:48 +0200
Subject: [PATCH 1/4] proc/vmcore: allow archs to override
	vmcore_elf_check_arch()
In-Reply-To: <20101116225042.GH21926@n2100.arm.linux.org.uk>
References: <cover.1289292124.git.mika.westerberg@iki.fi>
	<df680f67f33d8b0ef815045b53f205b3ff35de63.1289292124.git.mika.westerberg@iki.fi>
	<20101116142850.df5e9805.akpm@linux-foundation.org>
	<20101116225042.GH21926@n2100.arm.linux.org.uk>
Message-ID: <20101117105248.GV17801@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 10:50:42PM +0000, ext Russell King - ARM Linux wrote:
[...]
> 
> So, as far as the above patch goes, I think it's sane, as it now
> allows architectures to deal with the 64-bit/32-bit ELF issues in the
> crash dump code in a more sane manner.

Russell,

Is it ok if I submit this patch (along with patches 2 and 3) to your patch
system as Andrew suggested, or do you prefer to merge it via some other tree?

Thanks,
MW
