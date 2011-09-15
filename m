From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2011 12:43:13 +0200
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <1316017900-19918-6-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
Message-ID: <201109151243.13664.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 September 2011, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds gic initialization using device tree data. The initialization
> functions are intended to be called by a generic OF interrupt
> controller parsing function once the right pieces are in place.
> 
> PPIs are handled using 3rd cell of interrupts properties to specify the cpu
> mask the PPI is assigned to.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
