From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Jun 2016 16:14:00 +0200
Subject: [PATCH v8 0/2]  Fix dma mapping when the cache is coherent
In-Reply-To: <1460475070-29058-1-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Tue, 12 Apr 2016 17:31:08 +0200")
References: <1460475070-29058-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87vb199q6v.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On mar., avril 12 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> These two patches fixes the dma mapping functions when the system is
> cache coherent. The first one allows to fix an issue we have on Armada
> 375/38x with the PL310 that's why it is tagged for stable too.
>
> Thanks,
[..]
> Gregory CLEMENT (2):
>   ARM: dma-mapping: Don't use outer_flush_range when the L2C is coherent
>   ARM: dma-mapping: Fix the coherent case when iommu is used

I submit these two patches to your patch system 2 months ago:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8561/3
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8561/4

but they were not merged yet. Did you expect more change?
What can I do to help them to be merged?

I have just tested and these two patches still appply, as is, on the
v4.7-rc3 so there is no need to rebase them.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
