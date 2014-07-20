From: davidlohr@hp.com (Davidlohr Bueso)
Date: Sun, 20 Jul 2014 13:25:54 -0700
Subject: [PATCH 4/4] (RFC) X86: add IPI tracepoints
In-Reply-To: <1405660735-13408-5-git-send-email-nicolas.pitre@linaro.org>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-5-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1405887954.11927.5.camel@buesod1.americas.hpqcorp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-18 at 01:18 -0400, Nicolas Pitre wrote:
> On X86 there are already tracepoints for IRQ vectors through which IPIs
> are handled.  However this is highly X86 specific, and the IPI signaling
> is not currently traced.
> 
> This is an attempt at adding generic IPI tracepoints to X86.

I welcome this, and fwiw have been trying out this patch. One thing I
would like to see, but due to overhead would probably be better suited
in userspace (trace-cmd, maybe?), is a more packed description of the
IPI. Ie: unifying ipi_init and ipi_exit and show overall cost of the
IPI.

Thanks,
Davidlohr
