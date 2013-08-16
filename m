From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Aug 2013 18:05:00 +0530
Subject: [PATCH v4 1/5] ARM: davinci: fix clock lookup for mdio device
In-Reply-To: <1376546497-26931-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1376546497-26931-1-git-send-email-prabhakar.csengg@gmail.com>
 <1376546497-26931-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <520E1C74.7080101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 August 2013 11:31 AM, Lad, Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> This patch removes the clock alias for mdio device and adds a entry
> in clock lookup table, this entry can now be used by both DT and NON
> DT case.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Queuing for v3.12

Thanks,
Sekhar
