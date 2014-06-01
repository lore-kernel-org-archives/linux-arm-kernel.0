From: liviu@dudau.co.uk (Liviu Dudau)
Date: Sun, 1 Jun 2014 12:26:50 +0100
Subject: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
In-Reply-To: <4756033.LkcFQN0chs@wuerfel>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com>
 <1401496601-31983-2-git-send-email-Liviu.Dudau@arm.com>
 <4756033.LkcFQN0chs@wuerfel>
Message-ID: <20140601112648.GI1677@bart.dudau.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 08:41:04PM +0200, Arnd Bergmann wrote:
> On Saturday 31 May 2014 01:36:40 Liviu Dudau wrote:
> > We would like to be able to describe PCIe ECAM resources as
> > IORESOURCE_MEM blocks while distinguish them from standard
> > memory resources. Add an IORESOURCE_BIT entry for this case.
> > 
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> I still don't see any value in this at all. What is the advantage
> of doing this opposed to just having a standardized 'reg' property
> for a particular compatible string?

Oh, I agree. This patch was trying to provide an improved solution
to the original patch just in case someone considers this a worthwhile
exercise.

Best regards,
Liviu

> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
