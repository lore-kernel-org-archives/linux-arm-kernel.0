From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 22 Sep 2014 16:20:48 +0100
Subject: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <201409200424.20538.arnd@arndb.de>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
 <201409200424.20538.arnd@arndb.de>
Message-ID: <20140922152048.GZ1994@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 03:24:20AM +0100, Arnd Bergmann wrote:
> On Thursday 18 September 2014, Liviu Dudau wrote:
> > 
> > Add of_pci_get_domain_nr() to retrieve the PCI domain number
> > of a given device from DT. If the information is not present,
> > the function can be requested to allocate a new domain number.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> This is more elaborate than I remember it, and while the simpler
> version (which potentially resulted in a conflict for inconsistent
> DTs) was fine, this one also seems ok.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

Best regards,
Liviu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
