From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 1 Mar 2012 09:01:04 -0800
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861683@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Tuesday, February 28, 2012 5:03 PM:
> uImage files typically encode a single absolute load and entry address.
> This is inconvenient when attempting to share that uImage across multiple
> SoCs with different physical RAM addresses. Recent versions of mkimage
> implement a "kernel_noload" image type which encodes no absolute load
> address, and a relative entry address. This works well for uImage-wrapped
> ARM zImages, since they are relocatable.
> 
> This is enabled by commit b9b50e89d317c58becd0e2d7fac2e21e3a81dd0a
> "image: Implement IH_TYPE_KERNEL_NOLOAD" in U-Boot.

So Russell, are you NAKing this patch then?

If so, I guess I'll just go and add more cruft to my copy-a-kernel-to-
an-sd-card script. Which is a pity since every other person will have
to do the same, but oh well.

-- 
nvpublic
