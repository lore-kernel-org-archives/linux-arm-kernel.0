From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 22 Jul 2015 10:48:47 +0530
Subject: [PATCHv4 3/6] dmaengine: mv_xor: remove support for dmacap,* DT
 properties
In-Reply-To: <20150722051653.GR23525@localhost>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150722051653.GR23525@localhost>
Message-ID: <20150722051847.GS23525@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 10:46:53AM +0530, Vinod Koul wrote:
> On Wed, Jul 08, 2015 at 04:28:16PM +0200, Thomas Petazzoni wrote:

> > @@ -28,13 +31,8 @@ xor at d0060900 {
> >  
> >  	xor00 {
> >  	      interrupts = <51>;
> > -	      dmacap,memcpy;
> > -	      dmacap,xor;
> >  	};
> >  	xor01 {
> >  	      interrupts = <52>;
> > -	      dmacap,memcpy;
> > -	      dmacap,xor;
> > -	      dmacap,memset;
> I maybe wrong but there was an assumption that DT properties, even if bad
> are always there as they need to be treated as kernel ABI.
> 
> How will it work if someone has older DT implementation or older driver?
> 
> Arnd, what are the rules here and are they documented anywhere?
> 
Okay found one:
Documentation/devicetree/bindings/ABI.txt

-- 
~Vinod
