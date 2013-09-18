From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 18 Sep 2013 14:45:42 -0700
Subject: [PATCH v2 1/2] mtd: atmel_nand: remove #if defined(CONFIG_OF)
 around OF-specific code
In-Reply-To: <1379475080-14984-1-git-send-email-josh.wu@atmel.com>
References: <1379475080-14984-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20130918214542.GQ4550@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 11:31:19AM +0800, Josh Wu wrote:
> Since the of specific code are declared in <linux/of_mtd.h> regardless
> of CONFIG_OF. Remove the #if defined(CONFIG_OF) guard and use an
> IS_ENABLED(CONFIG_OF) instead.
> 
> Thanks to Ezequiel Garcia's for this protype.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Pushed both to l2-mtd.git. Thanks!

Brian
