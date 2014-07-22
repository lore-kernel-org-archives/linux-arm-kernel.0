From: xerofoify@gmail.com (Nick Krause)
Date: Tue, 22 Jul 2014 17:09:51 -0400
Subject: omap-wakeupgen.c: Remove function for fix me
Message-ID: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

static void __init irq_pm_init(void)
382 {
383         /* FIXME: Remove this when MPU OSWR support is added */
384         if (!soc_is_omap54xx())
385                 cpu_pm_register_notifier(&irq_notifier_block);
386 }
I am wondering is this omap supported now if it is can I remove it?
Cheers Nick
