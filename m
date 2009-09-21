From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 17:35:31 +0100
Subject: [PATCH v4 2/2] ARM: Proper prefetch abort handling on ARMv6
	and ARMv7
In-Reply-To: <8f6baf3261f6bde5b50142cbdf48b2e9e0821892.1253557409.git.kirill@shutemov.name>
References: <490fc9117572828816ebfec0200d7aad9e91075b.1253557409.git.kirill@shutemov.name>
	<8f6baf3261f6bde5b50142cbdf48b2e9e0821892.1253557409.git.kirill@shutemov.name>
Message-ID: <20090921163531.GE30821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 09:24:09PM +0300, Kirill A. Shutemov wrote:
> Currently, on ARMv6 and ARMv7, if an application tries to execute
> code (or garbage) on non-executable page it hangs. It caused by
> incorrect prefetch abort handling. Now every prefetch abort
> processes as a translation fault.

Please ensure that your patches apply on top of this set of patches:

http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/arm.diff

Thanks.
