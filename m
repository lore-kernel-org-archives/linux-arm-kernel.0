From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 21 Jul 2014 20:12:14 -0700
Subject: [PATCH v2 1/3] mtd: atmel_nand: add NFC status error check
In-Reply-To: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
References: <1402393811-24578-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20140722031214.GD7537@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 05:50:09PM +0800, Josh Wu wrote:
> Add a new function to read the NFC status. Meantime, this function will
> theck if there is any errors in NFC.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Fixed up some of the wording and pushed to l2-mtd.git. Thanks!

Brian
