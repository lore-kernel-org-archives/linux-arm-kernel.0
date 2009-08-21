From: hector.oron@gmail.com (Hector Oron)
Date: Fri, 21 Aug 2009 18:12:40 +0200
Subject: i.MX35 Kernel without ARM EABI support  cannot execute init
In-Reply-To: <1250865435.17931.20.camel@wks02-lin.nanotronic.local>
References: <1250865435.17931.20.camel@wks02-lin.nanotronic.local>
Message-ID: <20090821161240.GA20522@flaco.tsc-farm.upc.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 21, 2009 at 04:37:15PM +0200, hoefle marco wrote:
> When trying to boot the i.MX35 Kernel (with ARM EABI or without, the
> kernel panic remains exactly the same) using the emdebian rootfs I get
> this:
> 
> Kernel panic - not syncing: Attempted to kill init!
> Has anybody an idea why this is not working?

I have not much idea on what is missing, but Debian usually requires you to have an initrd image of your kernel and modules.
I am sorry I can help much.

Cheers,
		-- H?ctor Or?n
