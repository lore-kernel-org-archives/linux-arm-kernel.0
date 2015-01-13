From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 13 Jan 2015 13:41:28 +0100 (CET)
Subject: [RFC PATCH] irqchip: add dumb demultiplexer implementation
In-Reply-To: <20150113115830.43ef505d@bbrezillon>
References: <alpine.DEB.2.11.1412162125000.17382@nanos>
 <1420725159-20720-1-git-send-email-boris.brezillon@free-electrons.com>
 <alpine.DEB.2.11.1501131117120.17382@nanos>
 <20150113115830.43ef505d@bbrezillon>
Message-ID: <alpine.DEB.2.11.1501131340290.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jan 2015, Boris Brezillon wrote:
> Hmm, my question was not really clear: I was talking about irq flags [1]
> (those that are set with irq_modify_status in the generic irq chip [2]).

Ah, ok. Taking the same approach should be ok.

Thanks,

	tglx
