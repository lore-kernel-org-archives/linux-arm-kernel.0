From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Tue, 8 Dec 2015 09:32:24 +0100
Subject: [PATCH v2 18/25] cris: nand: remove useless mtd->priv = chip
 assignments
In-Reply-To: <1448967802-25796-19-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-19-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151208083224.GO22903@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 12:03:15PM +0100, Boris Brezillon wrote:
> mtd_to_nand() now uses the container_of() approach to transform an
> mtd_info pointer into a nand_chip one. Drop useless mtd->priv
> assignments from NAND controller drivers.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
