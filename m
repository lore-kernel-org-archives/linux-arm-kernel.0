From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Fri, 4 Jun 2010 17:48:08 +0300
Subject: [V3 0/7]Add i.MX51 3-stack board support
In-Reply-To: <1275660568-7738-1-git-send-email-jason77.wang@gmail.com>
References: <1275660568-7738-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100604144808.GC2982@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jun 04, Jason Wang wrote:
> I don't know why 2 patches([patch 2/3] and [patch 3/3]) are lost in
> the V2 review.
> In V3, i fix all comments both in V1 and V2.
> 
> Big diffs:
> 1) the number of patches increases from 3 to 7, because i add 1 3ds
> common debug board patch, 2 iomux pad rename and update patches and
> 1 revert mx31_3ds debug board relating stuffs patch.
> 
> 2) Though the smsc911x_platform_config is a little bit different
> between mx31_3ds and mx51_3ds originally,  when using the common
> configuration in the mxc debug board, they all works fine. I have
> validated these two BSPs through mounting NFS rootfs.
> 
> 3) the patch [3/7] is a rename and cleanup of iomux pad definition,
> i don't know if this update has been merged, if so, please drop
> it.

It didn't fail. Give it some time. :)

-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
