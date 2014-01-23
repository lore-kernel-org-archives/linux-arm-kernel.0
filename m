From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 22 Jan 2014 17:49:06 -0800
Subject: [RFC PATCH 1/9] mtd: nand: retrieve ECC requirements from Hynix
 READ ID byte 4
In-Reply-To: <1389190924-26226-2-git-send-email-b.brezillon@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389190924-26226-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20140123014906.GY8919@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Huang

Hi Boris,

On Wed, Jan 08, 2014 at 03:21:56PM +0100, Boris BREZILLON wrote:
> The Hynix nand flashes store their ECC requirements in byte 4 of its id
> (returned on READ ID command).
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

I haven't verified yet (perhaps Huang can confirm?), but this may be
similar to a patch Huang submitted recently. In his case, we found that
this table is actually quite unreliable and is likely hard to maintain.

Why do you need this ECC information, for my reference?

Brian
