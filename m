From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 14 Jul 2014 08:15:24 -0400
Subject: ARM: Kirkwood: mach-kirkwood's removal
In-Reply-To: <1405328105.8281.27.camel@x220>
References: <1405328105.8281.27.camel@x220>
Message-ID: <20140714121524.GO13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 10:55:05AM +0200, Paul Bolle wrote:
> 0) Commit ba364fc752da ("ARM: Kirkwood: Remove mach-kirkwood") is
> included in next-20140714. It removes quite a bit of code.
> 
> 1) The code it removes includes the Kconfig entries for
>     ARCH_KIRKWOOD
>     MACH_OPENRD_CLIENT
>     MACH_OPENRD_ULTIMATE
>     MACH_T5325
> 
> There are a few references to these Kconfig symbols still left in the
> tree. Are patches to remove these references queued somewhere?

Yes, those patches are to drivers and sub-systems.  They are going
through the respective trees.  You can see the whole series at:

  https://lkml.kernel.org/r/1405028192-9623-1-git-send-email-andrew at lunn.ch

> 2) And is a patch to remove the "arch/arm/mach-kirkwood/" pattern from
> MAINTAINERS queued somewhere?

oops. :)

> 3) By the way, MACH_KIRKWOOD looks related but is not removed in that
> commit. That's not an oversight, is it?

Nope.  That's the DT-only support for kirkwood in mach-mvebu/.

thx,

Jason.
