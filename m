From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:36:05 +0100
Subject: [PATCH 0/3] ARM: hisi: fix of_iomap errors
In-Reply-To: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
References: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
Message-ID: <5B4F5E65.4050503@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicholas,

On 2018/7/12 10:28, Nicholas Mc Guire wrote:
> This patch set addresses two issues in arch/arm/mach-hisi/hotplug.c
> 
> 1) The hisi hotplug functions were using a few unchecked 
>    of_iomap() while at the same time the system relied on
>    those mappings. Checks for !NULL were inserted.
> 
> 2) Further some mandatory of_node_put() were missing and have
>    been inserted.
> 
> 
> .
> 

Thanks!
Applied all the 3 patches to the hisilicon SoC tree.

Best Regards,
Wei
