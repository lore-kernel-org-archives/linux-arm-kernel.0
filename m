From: davem@davemloft.net (David Miller)
Date: Thu, 01 Nov 2012 11:46:42 -0400 (EDT)
Subject: [PATCH v4 00/10] net/macb: driver enhancement concerning GEM
 support, ring logic and cleanup
In-Reply-To: <cover.1351690694.git.nicolas.ferre@atmel.com>
References: <cover.1351690694.git.nicolas.ferre@atmel.com>
Message-ID: <20121101.114642.1433440763058405336.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 31 Oct 2012 17:04:49 +0100

> This is an enhancement work that began several years ago. I try to catchup with
> some performance improvement that has been implemented then by Havard.
> The ring index logic and the TX error path modification are the biggest changes
> but some cleanup/debugging have been added along the way.
> The GEM revision will benefit from the Gigabit support.
> Newer pinctrl infrastructure support is added but it is optional.
> 
> The series has been tested on several Atmel AT91 SoC with the two MACB/GEM
> flavors.
> 
> v4: - remove unneeded device tree header includes
>     - modified the computation of available entries in ring buffer
> v3: - rebased on net-next to take into account current effor to merge
>       at91_ether with macb drivers
>     - add additional patch to use the new pinctrl infrastructure
> v2: - modify the tx error handling: now uses a workqueue
>     - information provided by ethtool -i were not accurate: removed

Series applied to net-next
