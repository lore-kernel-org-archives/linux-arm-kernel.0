From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 09:37:25 +0100
Subject: [PATCH v3 1/2] ARM: Introduce ARM_L1_CACHE_SHIFT to define
	cache line size
In-Reply-To: <188e5f14411c04ec999ef25bfe3616f77f1387b0.1252788311.git.kirill@shutemov.name>
References: <188e5f14411c04ec999ef25bfe3616f77f1387b0.1252788311.git.kirill@shutemov.name>
Message-ID: <20090921083724.GA27357@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2009 at 11:48:30PM +0300, Kirill A. Shutemov wrote:
> Currently kernel believes that all ARM CPUs have L1_CACHE_SHIFT == 5.
> It's not true at least for CPUs based on Cortex-A8.

Please send this to the patch system.  There's no need to add the "V2"
comments to it when you do.
