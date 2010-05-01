From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 May 2010 11:11:23 +0100
Subject: [PATCH] [ARM] .gitignore: Ignore piggy.lzo, lib1funcs.S and
	vmlinux
In-Reply-To: <1272015498-10749-1-git-send-email-mroth@nessie.de>
References: <1272015498-10749-1-git-send-email-mroth@nessie.de>
Message-ID: <20100501101123.GF12172@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 23, 2010 at 11:38:18AM +0200, Michael Roth wrote:
> Commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c added LZO compressed
> kernels, lib1funcs.S is copied from the appropriate ARM sub-arch
> and vmlinux is the obvious fruit of all efforts.

Looks fine, please submit to the patch system if not already done so.
Thanks.
