From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Nov 2010 08:36:03 +0000
Subject: ARM: fix compile warning in mm/init.c
In-Reply-To: <1289542753-30185-1-git-send-email-gadiyar@ti.com>
References: <1289542753-30185-1-git-send-email-gadiyar@ti.com>
Message-ID: <20101112083602.GB28735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 11:49:13AM +0530, Anand Gadiyar wrote:
> Commit 7c63984b86 (ARM: do not define VMALLOC_END relative to PAGE_OFFSET)
> changed VMALLOC_END to be an explicit value. Before this, it was
> relative to PAGE_OFFSET and therefore automatically upgraded to
> unsigned long as PAGE_OFFSET was an unsigned long. This introduced
> the following build warning. Fix this.

Please fix your definition of VMALLOC_END.
