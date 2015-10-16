From: rogerq@ti.com (Roger Quadros)
Date: Fri, 16 Oct 2015 10:51:21 +0300
Subject: [PATCH 1/2 v2] ARM: DRA7/335x/437x/OMAP4: hwmod: Remove elm
 address space from hwmod data
In-Reply-To: <1444926461-16092-1-git-send-email-fcooper@ti.com>
References: <1444926461-16092-1-git-send-email-fcooper@ti.com>
Message-ID: <5620AC79.7010802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 19:27, Franklin S Cooper Jr wrote:
> ELM address information is provided by device tree. No longer need
> to include this information within hwmod.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

--
cheers,
-roger
