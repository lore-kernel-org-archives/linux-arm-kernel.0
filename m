From: pintu_agarwal@yahoo.com (PINTU KUMAR)
Date: Tue, 21 Feb 2012 01:15:43 -0800 (PST)
Subject: [HELP REQUIRED] : Andorid FIQ Debugger Porting issue on
 Kernel2.6.36
In-Reply-To: <1329815642.22876.YahooMailNeo@web162001.mail.bf1.yahoo.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-8-git-send-email-haojian.zhuang@marvell.com>
 <1329815642.22876.YahooMailNeo@web162001.mail.bf1.yahoo.com>
Message-ID: <1329815743.52839.YahooMailNeo@web162005.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?
Dear All,

This is regarding Android FIQ Debugger porting for another Linux mobile with kernel2.6.36.
I have successfully ported the fiq_debugger.c, fiq_glue.S and others and resolved the compilation issues.
I have enabled all the configs as below:
CONFIG_FIQ=y
CONFIG_FIQ_GLUE=y
CONFIG_FIQ_DEBUGGER=y
CONFIG_FIQ_DEBUGGER_NO_SLEEP=y
CONFIG_FIQ_DEBUGGER_WAKEUP_IRQ_ALWAYS_ON=y
CONFIG_FIQ_DEBUGGER_CONSOLE=y

But when I load the kernel on the device, the fiq handler is not getting called after I press ENTER?key many times during the following prompt.
<hit enter to activate fiq debugger>
---
---

What could be the problem?

Can anybody provide some pointers to debug further?



Thanks, Regards,
Pintu
