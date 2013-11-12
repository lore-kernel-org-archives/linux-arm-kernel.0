From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 12 Nov 2013 10:52:57 -0500
Subject: [PATCH 03/12] mtd: nand: davinci: simplify error handling
In-Reply-To: <4F5844B3A985794BA902E12C070812375F8CFB@DNCE04.ent.ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-4-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8CFB@DNCE04.ent.ti.com>
Message-ID: <52824ED9.5040104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 November 2013 11:54 AM, Khoronzhuk, Ivan wrote:
> There is not needed to use a lot of names for err handling.
> It complicates code support and reading.
> 
This is not always true but looking at the patch, the labels
are just useless since no special handling per label.

> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
