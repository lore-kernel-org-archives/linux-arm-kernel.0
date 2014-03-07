From: kentborg@borg.org (Kent Borg)
Date: Fri, 07 Mar 2014 18:14:59 -0500
Subject: SMP Documentation?
Message-ID: <531A52F3.1010303@borg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is there any documentation on the semantics of the SMP ops:

  - .smp_init_cpus,
  - .smp_prepare_cpus,
  - .smp_secondary_init,
  - .smp_boot_secondary?

I can certainly see examples in existing code, but I isn't clear to me 
why, for example, an SoC can't just do everything in smp_boot_secondary()?

Thanks,

-kb, the Kent who figures these four different calls are there for 
reasons, and there are a lot of ways for SMP to not work if he doesn't 
understand the reasons.
