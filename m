From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 16 Oct 2015 09:40:51 -0700
Subject: [PATCH v2 1/4] mtd: brcmnand: Fix pointer type-cast in
 brcmnand_write()
In-Reply-To: <56211976.1030401@broadcom.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
 <1444986537-28387-2-git-send-email-anup.patel@broadcom.com>
 <56211976.1030401@broadcom.com>
Message-ID: <20151016164051.GE108923@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 08:36:22AM -0700, Ray Jui wrote:
> Correct me if I remember it wrong, but I thought this patch has already
> been merged by Brian?

You are correct.

Anup,

Please base MTD patches on the MTD development tree (i.e., l2-mtd.git):

http://linux-mtd.infradead.org/source.html

(In this case it's no problem; I'll just ignore the first two patches.)

Brian
