From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 May 2010 15:26:25 +0100
Subject: [PATCH v6 2/2] ep93xx: SPI driver platform support code
In-Reply-To: <0D753D10438DA54287A00B0270842697636EB838E1@AUSP01VMBX24.collaborationhost.net>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<865b5d7ca0fae1977a1fadcdabdb715e3ea1604d.1272805161.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636EB838E1@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100505142625.GB2606@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 12:21:36PM -0500, H Hartley Sweeten wrote:
> That patch is already present in linux-next.  If Russell think there might
> be an issue you could rebase this patch on the linux-next tree.

If this patch depends on 5998/1, then I'll take it via the ep93xx branch
(which has 5998/1 on.)  It's only touching files in arch/arm so there
shouldn't be any problem with that.
