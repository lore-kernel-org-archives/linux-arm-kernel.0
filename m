From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Aug 2015 11:54:35 -0700
Subject: [PATCH 0/2] Add VIN and ADV7180 device tree support for
 R8A7794/SILK board
In-Reply-To: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
References: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
Message-ID: <20150820185435.GE18990@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 01:20:42AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
> 'renesas-devel-20150819-v4.2-rc7' tag. Here we add the VIN and ADV7180
> video decoder device tree support on the R8A7794/SILK board. The patchset
> requires previously posted SILK SDHI1 support patch in order to apply and 
> R8A7794/SILK I2C1 support in order to apply and build.
> 
> [1/2] ARM: shmobile: r8a7794: add VIN DT support
> [2/2] ARM: shmobile: silk: add VIN0/ADV7180 DT support

Thanks, I have queued these up for v4.4.
