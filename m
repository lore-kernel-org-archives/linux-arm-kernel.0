From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Jul 2016 08:38:22 +0200 (CEST)
Subject: SOC-specific action for irq_set_wake
In-Reply-To: <20160719224713.GA13533@hector.attlocal.net>
References: <20160719181804.GX3847@xsjsorenbubuntu>
 <20160719224713.GA13533@hector.attlocal.net>
Message-ID: <alpine.DEB.2.11.1607200836590.3564@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2016, Andy Gross wrote:

> So not too long ago there were irq extensions that you could add in to an
> irq controller that would allow for intercepting the set wake calls.  This
> went away and was replaced by the hierarchical irq design.

For a very good reason. The 'extensions' were a horrible hack and an
unmaintainable mess. This problem is not that hard to solve w/o these hacks.

Thanks,

	tglx
