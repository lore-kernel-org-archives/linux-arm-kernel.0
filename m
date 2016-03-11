From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 11 Mar 2016 08:16:09 +0100
Subject: [PATCH 1/5] dmaengine: sun6i: Fix the access of the IRQ register
In-Reply-To: <20160311063956.GQ11154@localhost>
References: <cover.1457606136.git.moinejf@free.fr>
 <f2fb59f3f06600a50ce95886ad25375eafc937da.1457606136.git.moinejf@free.fr>
 <20160311063956.GQ11154@localhost>
Message-ID: <20160311081609.0f670798145e3988b96ee50e@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Mar 2016 12:09:56 +0530
Vinod Koul <vinod.koul@intel.com> wrote:

> On Thu, Mar 10, 2016 at 10:15:22AM +0100, Jean-Francois Moine wrote:
> > The address of the IRQ register is computed, but its value was not
> 						^^^^^^^
> it's
> 
> > used and the register access was done by the channel index instead.
> > Then, only the first DMA channel was working.
> -- 

No. 'its value' is 'the value of the address'. I will re-phrase.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
