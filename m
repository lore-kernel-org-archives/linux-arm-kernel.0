From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 15 Jun 2012 17:07:49 +0100
Subject: How to use linear mapping without DT?
In-Reply-To: <20120615160155.GN31565@S2101-09.ap.freescale.net>
References: <4FD9B4DC.80706@atmel.com>
 <20120615160155.GN31565@S2101-09.ap.freescale.net>
Message-ID: <20120615160749.GA32135@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 16, 2012 at 12:01:57AM +0800, Shawn Guo wrote:

> Short answer - Don't use linear but legacy domain for non-DT. 

...except if the domain is internal to a device in which case the device
can easily find the domain to do the mappings and linear works perfectly
fine.

> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/151860/focus=152072

Note Grant's followup here, this applies to the case where you've got
devices using the interrupt controller with raw numbers.
