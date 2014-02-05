From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Feb 2014 15:00:02 +0100
Subject: [PATCH 09/10] watchdog: xilinx: Add missing binding
In-Reply-To: <52F20732.6070209@monstr.eu>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <201402051036.19428.arnd@arndb.de> <52F20732.6070209@monstr.eu>
Message-ID: <201402051500.02408.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 February 2014, Michal Simek wrote:
> On 02/05/2014 10:36 AM, Arnd Bergmann wrote:
> > On Wednesday 05 February 2014, Michal Simek wrote:
> > Still, the choice of putting the timeout into DT in terms of
> > cycles rather than miliseconds wasn't ideal from an interface
> > perspective and we should change that if/when we do a generic
> > binding. I can definitely see where it's coming from for your
> > case, as the cycle count totally makes sense from an FPGA
> > tool perspective...
> 
> Thanks. I take this like ACK for this current binding description.
> 

Yes, please add my 'Acked-by'.

	Arnd
