From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 13 Oct 2011 22:12:40 +0200 (CEST)
Subject: [PATCH v2] irq: support domains with non-zero hwirq base
In-Reply-To: <20111013193347.GB18574@ponder.secretlab.ca>
References: <20111004233953.GE3009@ponder.secretlab.ca>
	<1317783380-773-1-git-send-email-robherring2@gmail.com>
	<4E944242.10606@gmail.com>
	<20111013193347.GB18574@ponder.secretlab.ca>
Message-ID: <alpine.LFD.2.02.1110132212120.3240@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Grant Likely wrote:

> Thomas, any objection to this patch?  It's entirely contained within
> the irq_domain stuff, so it is pretty well isolated.
> 
> It can be merged via arm-soc since it is depended on by some of the
> irq work.
 
Acked-by-me
