From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 Jan 2015 12:09:03 +0100
Subject: [PATCH] iommu: Fix build of allmod/allyes config on ARMv8
 architecture
In-Reply-To: <20150105110347.GB19590@8bytes.org>
References: <1417787257-10056-1-git-send-email-k.kozlowski@samsung.com>
 <20150105110347.GB19590@8bytes.org>
Message-ID: <1420456143.31776.3.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2015-01-05 at 12:03 +0100, Joerg Roedel wrote:
> On Fri, Dec 05, 2014 at 02:47:37PM +0100, Krzysztof Kozlowski wrote:
> >  drivers/iommu/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied to iommu/fixes, thanks.

Thanks, but... Few days after my patch Mark Brown posted something
similar:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310743.html

It was merged by Arnd Bergman and sent to Linus around 3.19-rc1. It is
merged in mainline now:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=20911ce6078fd1503dbf73f761316c66738bf83b

... so my patch can be dropped.

Best regards,
Krzysztof
