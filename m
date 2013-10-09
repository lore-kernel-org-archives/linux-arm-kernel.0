From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 9 Oct 2013 12:54:31 -0400 (EDT)
Subject: [RFC PATCH 1/4] ARM: Allow assembler.h to be used with inline asm
In-Reply-To: <20131009161006.GC2306@localhost.localdomain>
References: <20131009161006.GC2306@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1310091253020.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Dave Martin wrote:

> It could make sense to add the new helper to asm/swab.h, but that might
> result in pollution when it's included via linux/swab.h.

Yet its name is specific enough that this is rather unlikely.  So maybe 
this would be the best compromize.


Nicolas
