From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Aug 2013 09:11:40 +0900
Subject: [PATCH v5 0/3] R8A7779/Marzen R-Car VIN driver support
In-Reply-To: <201308230119.13783.sergei.shtylyov@cogentembedded.com>
References: <201308230119.13783.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130823001140.GD9254@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 01:19:13AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    [Resending with a real version #.]
> 
>    Here's the set of 3 patches against the Mauro's 'media_tree.git' repo's
> 'master' branch. Here we add the VIN driver platform code for the R8A7779/Marzen
> with ADV7180 I2C video decoder.
> 
> [1/3] ARM: shmobile: r8a7779: add VIN support
> [2/3] ARM: shmobile: Marzen: add VIN and ADV7180 support
> [3/3] ARM: shmobile: Marzen: enable VIN and ADV7180 in defconfig
> 
>     Mauro has kindly agreed to merge this patchset thru his tree to resolve the
> dependency on the driver's platform data header, provided that the maintainer
> ACKs this. Simon, could you ACK the patchset ASAP -- Mauro expects to close his
> tree for 3.12 this weekend or next Monday?

All three patches:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
