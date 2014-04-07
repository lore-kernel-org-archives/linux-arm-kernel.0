From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 07 Apr 2014 19:13:28 +1000
Subject: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <20140407083550.GF17163@e106497-lin.cambridge.arm.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-2-git-send-email-Liviu.Dudau@arm.com>
 <20140405001953.GE15806@google.com> <1396777793.3671.15.camel@pasglop>
 <20140407083550.GF17163@e106497-lin.cambridge.arm.com>
Message-ID: <1396862008.3671.39.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 09:35 +0100, Liviu Dudau wrote:
> Thanks for the summary, is really useful as I was recently looking
> into code in that
> area. One thing I was trying to understand is why ppc needs _IO_BASE
> at all rather
> than using the generic PCI_IOBASE? 

Perhaps because our code predates it ? :-) I haven't looked much into
the semantics of PCI_IOBASE yet...

Cheers,
Ben.
