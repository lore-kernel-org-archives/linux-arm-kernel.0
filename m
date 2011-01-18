From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 18 Jan 2011 16:30:41 +0200
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Message-ID: <20110118143041.GA13576@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 07:20:50PM +0000, Russell King - ARM Linux wrote:
> This patch series reworks the ARMv6/ARMv6K support options, code
> selection, and bit operations such that it's possible to safely
> build a kernel which supports ARMv6, ARMv6K, ARMv7 and ARMv7 SMP
> in one image.

Is it posible to implement CPU_ARCH_ARMv6K as well for runtime checks?

-- 
 Kirill A. Shutemov
