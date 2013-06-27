From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jun 2013 16:41:29 +0900
Subject: [PATCH v4 0/3] R8A7779/Marzen R-Car VIN driver support
In-Reply-To: <201305160153.29827.sergei.shtylyov@cogentembedded.com>
References: <201305160153.29827.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130627074129.GB13927@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 01:53:29AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130515v2' tag and my recent yet unapplied USB/I2C patches.
> Here we add the VIN driver platform code for the R8A7779/Marzen with ADV7180
> I2C video decoder.
> 
> [1/3] ARM: shmobile: r8a7779: add VIN support
> [2/3] ARM: shmobile: Marzen: add VIN and ADV7180 support
> [3/3] ARM: shmobile: Marzen: enable VIN and ADV7180 in defconfig
> 
>    The VIN driver itself has been excluded from the series as it will be developed
> against Mauro's 'media_tree.git' plus some yet unapplied patches in the future...

Sergei, is this patch-set still needing review?
