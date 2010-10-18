From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 18 Oct 2010 14:46:55 +0200
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <1287387875-14168-1-git-send-email-ohad@wizery.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
Message-ID: <1287406015.29097.1579.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 09:44 +0200, Ohad Ben-Cohen wrote:
> OMAP4 introduces a Spinlock hardware module, which provides hardware
> assistance for synchronization and mutual exclusion between heterogeneous
> processors and those not operating under a single, shared operating system
> (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP). 

I just have to ask... was it really easier to build silicon than to
agree on a spinlock ABI?
