From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Jul 2014 11:23:28 -0500
Subject: Function Profiler broken on today's linux-next
Message-ID: <20140716162328.GJ1365@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

I was trying to use Kernel Function Profiler to figure out why my
driver's IRQ handler is taking so much CPU time but to my surprise,
whenever I try to trace anything, I get a "Unable to handle kernel
paging request at virtual address XXXX" error.

Is anybody else seen that or did I screw up my Kernel config ?

cheers

ps: I have tried tracing a few different drivers and they all trigger
the same problem.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/a9927012/attachment.sig>
