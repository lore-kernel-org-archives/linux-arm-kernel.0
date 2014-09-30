From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 30 Sep 2014 16:42:02 +0100
Subject: [PATCH] of/pci: add pci_pio_to_address dummy for !CONFIG_OF
In-Reply-To: <2033939.5UfzeSiRKs@wuerfel>
References: <706416181.hbVGLDA3o6@wuerfel>
 <20140930144506.GQ841@e106497-lin.cambridge.arm.com>
 <2033939.5UfzeSiRKs@wuerfel>
Message-ID: <20140930154201.GR841@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 04:15:19PM +0100, Arnd Bergmann wrote:
> On Tuesday 30 September 2014 15:45:06 Liviu Dudau wrote:
> > 
> > Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > 
> > Is that triggered by shmobile_defconfig?
> > 
> > 
> 
> No, I only found it using randconfig testing, shmobile enables CONFIG_OF by
> default.

Hmm, I was looking at who defines CONFIG_PCI_RCAR_GEN2_PCIE and it's only
present in shmobile_defconfig, but that one does not select any OF options (other
than CONFIG_ARM_APPENDED_DTB). So there is no way of triggering this other
than by randconfig?

Best regards,
Liviu

> 
> 	Arnd
> 
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
