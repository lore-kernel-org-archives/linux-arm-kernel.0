From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 15 Aug 2012 01:47:15 +0200 (CEST)
Subject: [PATCH v2 03/31] arm64: Exception handling
In-Reply-To: <20120814232907.GB19607@quad.lixom.net>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-4-git-send-email-catalin.marinas@arm.com>
 <20120814232907.GB19607@quad.lixom.net>
Message-ID: <alpine.LFD.2.02.1208150146460.32033@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Aug 2012, Olof Johansson wrote:
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > new file mode 100644
> > index 0000000..8712a8e
> > --- /dev/null
> > +++ b/arch/arm64/kernel/traps.c
> [...]
> > +DEFINE_SPINLOCK(die_lock);
> 
> Should probably be static.

And RAW_
