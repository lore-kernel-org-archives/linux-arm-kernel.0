From: olof@lixom.net (Olof Johansson)
Date: Wed, 5 Aug 2015 17:26:27 +0200
Subject: [patch 00/11] ARM: Interrupt cleanups and API change preparation
In-Reply-To: <20150713090726.316699641@linutronix.de>
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150805152627.GA31397@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 08:28:58PM -0000, Thomas Gleixner wrote:
> The following patch series contains the following changes:
> 
>     - Consolidation of chained interrupt handler setup/removal
> 
>     - Switch to functions which avoid a redundant interrupt
>       descriptor lookup
> 
>     - Preparation of interrupt flow handlers for the 'irq' argument
>       removal
> 
> The series has no dependencies and is also available as a git branch
> for your convenience:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/arm
> 
> If you want me to carry the patches in the irq/core branch of tip,
> please let me know.

I've now merged this into next/cleanup in arm-soc (for 4.3).

Thanks!


-Olof
