From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2009 16:34:41 +0100
Subject: [PATCH 3/4] Revert 75f4aa1 (unconditionally define
	__virt_to_phys and __phys_to_virt)
In-Reply-To: <20091015122204.739.25384.stgit@pc1117.cambridge.arm.com>
References: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
	<20091015122204.739.25384.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091019153441.GF13614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2009 at 01:22:04PM +0100, Catalin Marinas wrote:
> The SPARSEMEM support for RealView PBX requires non-linear physical to
> virtual address translation.

Since we have two platforms which are wanting this, I think this shouldn't
be a separate patch, but merely just a 'git revert' of the original.
