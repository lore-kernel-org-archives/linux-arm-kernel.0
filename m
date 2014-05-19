From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 11:19:15 +0200
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency
 in non-SMP platforms
In-Reply-To: <20140516151130.GB7171@localhost>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
 <20140515115010.0d6a4d92@free-electrons.com>
 <20140515142205.GC1499@arm.com>
 <CAL_JsqK80pFHQBgMxc1FGi998UYnbKxOK2gbm_ftqrTaxNq4rA@mail.gmail.com>
 <20140515152553.GA30423@localhost>
 <CAL_JsqKSzsyi-XmTKRK=87Z5wFzDjXaLNHj_irOM4V2-8ds1Tw@mail.gmail.com>
 <20140516151130.GB7171@localhost>
Message-ID: <20140519111915.7cfe0470@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Fri, 16 May 2014 16:11:30 +0100, Catalin Marinas wrote:

> > My question is should the kernel unconditionally enable the SCU
> > regardless of CONFIG_SMP or any other condition? Is there harm in
> > enabling the SCU when in AMP mode?
> 
> I don't see why we couldn't always enable the SCU at boot, whether the
> OS runs SMP, AMP or UP mode.

Does this means that my "[RFC PATCHv1 4/7] ARM: kernel: allow the SCU
to be enabled even on !SMP" is OK ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
