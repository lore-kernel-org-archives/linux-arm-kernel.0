From: rabin@rab.in (Rabin Vincent)
Date: Sat, 22 Aug 2009 00:07:55 +0530
Subject: i.MX35 Kernel without ARM EABI support  cannot execute init
In-Reply-To: <1250865435.17931.20.camel@wks02-lin.nanotronic.local>
References: <1250865435.17931.20.camel@wks02-lin.nanotronic.local>
Message-ID: <20090821183754.GA3017@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2009 at 04:37:15PM +0200, hoefle marco wrote:
> When trying to boot the i.MX35 Kernel (with ARM EABI or without, the
> kernel panic remains exactly the same) using the emdebian rootfs I get
> this:
> 
> Kernel panic - not syncing: Attempted to kill init!

If you build your kernel with CONFIG_DEBUG_USER=y and pass in
"user_debug=31" on your kernel command line, you'll get some info on why
init is being killed.

Rabin
