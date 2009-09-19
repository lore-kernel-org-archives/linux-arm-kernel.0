From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Sep 2009 12:03:16 +0100
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <c9f73fa56a41bc1051cd347cc453081235e3d776.1253307263.git.kirill@shutemov.name>
References: <c9f73fa56a41bc1051cd347cc453081235e3d776.1253307263.git.kirill@shutemov.name>
Message-ID: <20090919110316.GA23452@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2009 at 11:55:42PM +0300, Kirill A. Shutemov wrote:
> It needed for proper prefetch abort handling on ARMv7.

I think the only thing which is missing is an explaination about why
this is desirable given that only later CPUs can give this additional
information.
