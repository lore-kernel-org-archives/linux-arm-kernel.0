From: liviu@dudau.co.uk (Liviu Dudau)
Date: Mon, 18 Aug 2014 22:35:47 +0100
Subject: [PATCH v9 00/12] Support for creating generic PCI host bridges
 from DT
In-Reply-To: <20140818142622.GP20043@localhost>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <20140818142622.GP20043@localhost>
Message-ID: <20140818213546.GD13147@bart.dudau.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 03:26:22PM +0100, Catalin Marinas wrote:
> On Tue, Aug 12, 2014 at 05:25:13PM +0100, Liviu Dudau wrote:
> > This is my updated attempt at adding support for generic PCI host
> > bridge controllers that make use of device tree information to
> > configure themselves. This version incorporates Catalin's proposal
> > for managing domain numbers that got Bjorn's approval. I am now requesting
> > ACKs from the relevant maintainers as I would like to get the upstream ball
> > rolling.
> 
> As this series kept me busy on a long flight, you can add:

Damn, I don't know wether I should be proud or scared.

> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks! :)

Liviu

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
