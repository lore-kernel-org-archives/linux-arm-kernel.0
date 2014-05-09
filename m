From: mark.roszko@gmail.com (Mark Roszko)
Date: Fri, 9 May 2014 18:23:07 -0400
Subject: [PATCH] i2c/nuc900: fix ancient build error
In-Reply-To: <1399560990-1402858-11-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-11-git-send-email-arnd@arndb.de>
Message-ID: <CAJjB1qKWDN8dThK+P6VT40_F1t3b5_EOgfY0PFOCbsQ66XNFXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"[PATCH] NUC900: patch for implement clk_get_rate"
https://lkml.org/lkml/2010/6/15/147

This patch would have fixed the apbfreq not being a real struct member
and would also explain why clk_get_rate is called without using it's
return value in the line above what you have.

>From 2010, so it got dropped somewhere and ignored/abandoned
