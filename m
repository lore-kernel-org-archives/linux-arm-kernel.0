From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 9 Mar 2018 20:07:07 -0500 (EST)
Subject: [PATCH 0/7] further linker script cleanups
In-Reply-To: <TY1PR01MB1562E277A5DD0DB66E49F4778ADE0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
 <TY1PR01MB1562E277A5DD0DB66E49F4778ADE0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1803092005480.7678@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Mar 2018, Chris Brandt wrote:

> On Thursday, March 08, 2018 1, Nicolas Pitre wrote:
> > This series continues on the linker script cleanups that were started in
> > commit 0d302c710b ("ARM: vmlinux-xip.lds.S: fix multiple issues"). Many
> > duplications between the XIP and non-XIP scripts are factored out in a
> > common file, and the TCM support with an XIP kernel is now possible.
> > 
> > This makes for a nice diffstat:
> 
> Thank you Nicolas for your continued work on XIP_KERNEL.
> 
> As you can expect, since you were just move things around, everything 
> still builds and boots fine on my system.
> 
>   Renesas RZ/A1: Cortex-A9 with MMU enabled
> 

Still good to know that I didn't break anything.
Thanks for testing.


Nicolas
