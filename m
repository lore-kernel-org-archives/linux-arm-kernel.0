From: arjan@infradead.org (Arjan van de Ven)
Date: Fri, 17 Jun 2011 21:08:56 -0700
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110615165321.GC23151@in.ibm.com>
References: <20110610165529.GC2230@linux.vnet.ibm.com>
	<20110610170535.GC25774@srcf.ucam.org>
	<20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
	<20110610175248.GF2230@linux.vnet.ibm.com>
	<20110610180807.GB28500@srcf.ucam.org>
	<20110610184738.GG2230@linux.vnet.ibm.com>
	<20110610192329.GA30496@srcf.ucam.org>
	<20110610193713.GJ2230@linux.vnet.ibm.com>
	<20110610200233.5ddd5a31@infradead.org>
	<20110615165321.GC23151@in.ibm.com>
Message-ID: <20110617210856.1dd3b482@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun 2011 22:23:21 +0530
Ankita Garg <ankita@in.ibm.com> wrote:

> The maximum order in buddy allocator is by default 1k pages. Isn't
> this too small a granularity to track blocks that might comprise a
> PASR unit? 

we had to bump the default up a little, but not all that much

(like 4x)
