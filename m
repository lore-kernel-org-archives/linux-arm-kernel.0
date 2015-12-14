From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 14 Dec 2015 10:31:12 -0800
Subject: [PATCH] mtd: omap_elm: print interrupt resource using %pr
In-Reply-To: <1472979.NmboBT3Vms@wuerfel>
References: <2101351.RbJOfbsbGX@wuerfel> <20151212011056.GA144873@google.com>
 <1472979.NmboBT3Vms@wuerfel>
Message-ID: <20151214183112.GB10460@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2015 at 03:41:31PM +0100, Arnd Bergmann wrote:
> On Friday 11 December 2015 17:10:56 Brian Norris wrote:
> > drivers/mtd/nand/omap_elm.c:417 elm_probe() error: '%pr' expects argument of type struct resource *, but argument 3 has type 'struct resource**' [smatch]
> 
> Ah, good catch. Do you want to fix it up yourself, or should I send a new version?

Can you send a new one?
