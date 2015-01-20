From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 20 Jan 2015 12:47:40 -0800
Subject: [PATCH 1/2] mtd: atmel_nand: introduce a new compatible string
 for sama5d4 chip
In-Reply-To: <1421656387-12538-1-git-send-email-josh.wu@atmel.com>
References: <1421656387-12538-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150120204740.GR9759@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 04:33:06PM +0800, Josh Wu wrote:
> Since in SAMA5D4 chip, the PMECC can correct bit flips in erased page.
> So we add a DT property to indicate this hardware character.
> 
> If the PMECC support correct bitflip erased page (all data are 0xff).
> Then we can use the PMECC correct the page and skip the erased page
> check.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git.

Brian
