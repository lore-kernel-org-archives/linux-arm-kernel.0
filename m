From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Tue, 8 Dec 2015 09:35:13 +0100
Subject: [PATCH v2 15/25] cris: nand: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1448967802-25796-16-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
 <1448967802-25796-16-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151208083513.GQ22903@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 12:03:12PM +0100, Boris Brezillon wrote:
> struct nand_chip now embeds an mtd device. Patch all drivers to make use
> of this mtd instance instead of using the instance embedded in their
> private struct or dynamically allocated.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
