From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 21 Nov 2014 11:43:47 +0100
Subject: arm: pxa: CPU_PXA27x?
Message-ID: <1416566627.6958.16.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert,

Your commit 03ec7fe70c5c ("arm: pxa: add pxa27x device-tree support") is
included in today's linux-next (ie, next-20141121). It adds a select
statement for CPU_PXA27x. But there's no Kconfig symbol CPU_PXA27x.

Why is that select needed? For what it's worth: __cpu_is_pxa27x()
compiles to something interesting if CONFIG_PXA27x is defined.

In https://lkml.org/lkml/2014/9/30/578 I proposed a patch that emits a
warning in cases like this. Like _all_ Kconfig related patches I've seen
flying by lately it appears to be dropped in /dev/null. What's going on?


Paul Bolle
