From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 19 Jan 2017 22:04:32 +0200
Subject: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <20170119195701.kueutgmahr6bmxhq@sirena.org.uk>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
 <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
 <20170119195701.kueutgmahr6bmxhq@sirena.org.uk>
Message-ID: <1484856272.2133.253.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-01-19 at 19:57 +0000, Mark Brown wrote:
> On Thu, Jan 19, 2017 at 08:37:40PM +0100, Jan Kiszka wrote:
> > When using the a device with edge-triggered interrupts, such as
> > MSIs,
> > the interrupt handler has to ensure that there is a point in time
> > during
> 
> I'm missing patches 1 and 3, what's going on here?

Patch 1 had been applied by you. I think Jan just needs to resend with
proper version and set of patches.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
