From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Jul 2014 00:43:28 -0700
Subject: omap-wakeupgen.c: Remove function for fix me
In-Reply-To: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
References: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
Message-ID: <20140723074328.GI18374@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nick Krause <xerofoify@gmail.com> [140722 14:12]:
> static void __init irq_pm_init(void)
> 382 {
> 383         /* FIXME: Remove this when MPU OSWR support is added */
> 384         if (!soc_is_omap54xx())
> 385                 cpu_pm_register_notifier(&irq_notifier_block);
> 386 }
> I am wondering is this omap supported now if it is can I remove it?

Does REVISIT cause issues for you with cscope? It may be easier to
replace the cscope bugging FIXME statements with just REVISIT unless
a real fix is provided.

Regards,

Tony
