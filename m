From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 22 Apr 2014 14:20:43 -0400
Subject: [PATCH v3 0/3] ARM: OMAP2+: AM437x: L2 cache support
In-Reply-To: <cover.1398149526.git.nsekhar@ti.com>
References: <cover.1398149526.git.nsekhar@ti.com>
Message-ID: <5356B2FB.5090205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 04:28 AM, Sekhar Nori wrote:
> This patch series adds L2 cache support for AM437x
> and does some clean-ups for existing OMAP4 support
> along the way (no functional changes). On OMAP4 Panda,
> the Aux control value remains 0x7e470000 before and
> after the series.
> 
> Tested on OMAP4 Panda and AM437x EPOS EVMs.
> 
> It is based on RMK's 75 patch series titled "l2c series" +
> the patch contained in https://www.mail-archive.com/linux-omap at vger.kernel.org/msg103439.html
> 
> Sekhar Nori (3):
>   ARM: OMAP2+: L2 cache: get rid of init call
>   ARM: OMAP2+: L2 cache: git rid of redundant cache replacement policy
>     setting
>   ARM: OMAP2+: AM43x: L2 cache support
> 
For the whole series,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
