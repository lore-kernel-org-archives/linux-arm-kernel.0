From: horms@verge.net.au (Simon Horman)
Date: Mon, 22 Apr 2013 13:21:20 +0900
Subject: [PATCH 0/5] OKI ML86V7667 driver and R8A7778/BOCK-W VIN support
In-Reply-To: <201304210013.46110.sergei.shtylyov@cogentembedded.com>
References: <201304210013.46110.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130422042120.GN15680@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 21, 2013 at 12:13:45AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 4 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130419' tag and my recent yet unapplied patches. Here we
> add the OKI ML86V7667 video decoder driver and the VIN platform code working on
> the R8A7778/BOCK-W with ML86V7667. The driver patch also applies (with offsets)
> to Mauro's 'media_tree.git'...
> 
> [1/5] V4L2: I2C: ML86V7667 video decoder driver
> [2/5] sh-pfc: r8a7778: add VIN pin groups
> [3/5] ARM: shmobile: r8a7778: add VIN support
> [4/5] ARM: shmobile: BOCK-W: add VIN and ADV7180 support
> [5/5] ARM: shmobile: BOCK-W: enable VIN and ADV7180 in defconfig

Hi Sergei,

it seems to me that patches 2 and 3 of the series could
be applied to my tree without further delay. Would you
like me to do that?
