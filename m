From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 4 Jul 2014 10:44:40 +0100
Subject: [PATCH] arm64: PCI(e) arch support
In-Reply-To: <53B5F81B.8010801@freescale.com>
References: <1404422876-1160-1-git-send-email-tinamdar@apm.com>
 <53B5F81B.8010801@freescale.com>
Message-ID: <20140704094440.GC6501@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 01:40:59AM +0100, Prabhakar Kushwaha wrote:
> Hi Tanmay, Liviu,
> On 7/4/2014 2:57 AM, Tanmay Inamdar wrote:
> > Reposting on request of several people since previously posted one was
> > corrupted.
> >
> > This patch adds the arch support for PCI(e) for arm64. The files
> > added or modified in this patch are based on PCI(e) support in
> > 32bit arm.
> >
> > Please note that this patch is just for the reference. Liviu Dudau from ARM
> > has posted his v8 series of patch to support PCIe in arm64.
> >
> > The patch will apply against 3.13 Linux Kernel
> >
> > Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> >
> 
> do we foresee similar type of changes in u-boot  to support PCI(e) for 
> ARM64.

I'm afraid I'm not familiar with u-boot's support for PCI(e), so I cannot
answer that. As a general matter, ARM has decided to officially support
UEFI as a bootloader for ARMv8 and that already has support for PCI(e),
one only needs a driver for the specific host bridge.

Best regards,
Liviu

> 
> Regards,
> Prabhakar
> 
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
