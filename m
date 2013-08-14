From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 14 Aug 2013 17:34:13 +0530
Subject: [PATCH v3 1/6] ARM: davinci: da8xx: fix clock lookup for mdio
 device
In-Reply-To: <1371999607-6483-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1371999607-6483-1-git-send-email-prabhakar.csengg@gmail.com>
 <1371999607-6483-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <520B723D.5020400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

On 6/23/2013 8:30 PM, Prabhakar Lad wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> This patch removes the clock alias for mdio device and adds a entry
> in clock lookup table, this entry can now be used by both DT and NON
> DT case.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: netdev at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Heiko Schocher <hs@denx.de>

This patch looks good, except you can do the same thing on all DaVinci
devices not just on DA8XX. Apart from this patches 1-5 in this series
look good. If you can spin this fix in short time I can queue 1-5 for
v3.12 while we wait for you to fix 6/6

Thanks,
Sekhar
