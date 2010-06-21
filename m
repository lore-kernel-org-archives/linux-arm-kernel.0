From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 14:19:03 +0100
Subject: [PATCH v4 0/8] Patches/fixes for 2.6.35
In-Reply-To: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
References: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621131903.GA13624@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 11:29:29AM +0100, Catalin Marinas wrote:
> Updates from version 3 of these series:
> 
> - noMMU warning patch changed by moving the CONSISTENT_* definitions to
>   the CONFIG_MMU section
> - .phys_io alignment patch replaced by two patches that enforce the
>   alignment in the machine_desc structures for VExpress and RealView
> - commit log added to the T2 module relocations patch

Ok.
