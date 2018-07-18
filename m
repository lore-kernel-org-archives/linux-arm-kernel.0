From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Jul 2018 11:57:15 -0700
Subject: [PATCH V2 0/5] arm64: Initial support Texas Instrument's AM654
 Platform
In-Reply-To: <20180718180455.gaej4fgf47zytdxk@kahuna>
References: <20180626162615.19194-1-nm@ti.com>
 <20180718180455.gaej4fgf47zytdxk@kahuna>
Message-ID: <20180718185715.GG99251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [180718 18:08]:
> On 16:26-20180626, Nishanth Menon wrote:
> > Hi,
> > 
> > This is an minor update from V1 posted earlier:
> > 	https://marc.info/?l=linux-kernel&m=152943745424138&w=2
> > 
> > The following series enables support for newest addition in TI's SoC
> > portfolio - AM654 SoC.
> > 
> > The series is based off v4.18-rc1, also available here:
> > https://github.com/nmenon/linux-2.6-playground/tree/upstream/v4.18-rc1/k3-1-am6-base
> > 
> > Key changes since RFC are indicated in respective patches:
> > * Pickedup Tony's Reviewed by
> > * Modified cbass nodes to indicate interconnect (patch #3 in the series)
> 
> Hi Tony,
> 
> Apologies on the off-request. Looks like Tero might be on vacation
> and might not be able to send the Pull request to arm-soc folks on time.
> 
> Requesting you to pick them up on our behalf for v4.19 if it that is
> fine with you. We do have Rob's ack on the bindings themselves, and
> the patches also have been reviewed as well.

Sure applying the whole series into am654-for-v4.19 branch.

Regards,

Tony
