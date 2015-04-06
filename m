From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 5 Apr 2015 18:00:02 -0700
Subject: [PATCH] mtd: atmel_nand: don't map the ROM table if no pmecc
 table offset in DT
In-Reply-To: <1427955227-8927-1-git-send-email-josh.wu@atmel.com>
References: <1427955227-8927-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150406010002.GH2677@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 02:13:47PM +0800, Josh Wu wrote:
> if atmel,pmecc-lookup-table-offset is not found in DT node, we don't
> need to map the ROM table as we will build a runtime gf table anyway.
> 
> Reported-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git.

Brian
