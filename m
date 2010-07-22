From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 11:03:26 +0100
Subject: [PATCH 0/9] CM's patches for the next merging window(s)
In-Reply-To: <20100719133050.24290.70856.stgit@e102109-lin.cambridge.arm.com>
References: <20100719133050.24290.70856.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100722100326.GC31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 02:43:57PM +0100, Catalin Marinas wrote:
> This is a series of patches I maintain in my tree at (the 'rebased'
> branch for individual patches or 'master' for a merge-friendly branch):

I think patches 2 through 9 are fine.

I think you and Tony need to discuss patch 1 - you point out that there's
an issue writing the TLS value after this change, and Tony's patches
change the way that the TLS code works.  I'd like to hear that there's
no issue if both patches were to be merged.
