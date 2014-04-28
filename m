From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 28 Apr 2014 21:00:56 +0200
Subject: [PATCH 00/16] Another 16 L2C patches
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <1909837.hsUUrWVtDV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 28. April 2014, 17:56:31 schrieb Russell King - ARM Linux:
> So, in response to Matt Porter's complaint about breaking prima2, here's
> another 16 patches which changes the way the L2 cache is initialised on
> many platforms.  This series moves towards a situation where the generic
> code initialises the L2 cache itself, with as little help as possible
> from board specific code.

Patches 2/16 ("ARM: l2c: add platform independent core L2 cache
initialisation") and 3/16 ("ARM: l2c:  convert rockchip to generic l2c 
initialisation") applied on a linux-next from 20140428,

Tested-by: Heiko Stuebner <heiko@sntech.de>
