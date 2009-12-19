From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Dec 2009 09:03:32 +0000
Subject: [PATCH 4/5] arm: Fix init_atags_procfs() to check tag->hdr.size
In-Reply-To: <20091219034630.26198.35713.stgit@localhost>
References: <20091219034151.26198.26570.stgit@localhost>
	<20091219034630.26198.35713.stgit@localhost>
Message-ID: <20091219090332.GA28047@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 07:46:30PM -0800, Tony Lindgren wrote:
> The tag->hdr.size cannot be larger than XXX.
> Otherwise we can getsomething similar during boot:
> 
> Unable to handle kernel paging request at virtual address 61a05020
> ...

NAK.

Why can't people get the simple ATAG setup right?  Fix the boot loader.
