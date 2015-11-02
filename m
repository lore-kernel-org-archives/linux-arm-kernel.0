From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 2 Nov 2015 17:02:18 +0000
Subject: [PATCH v5 0/3] NAND support for Broadcom NS2 SoC
In-Reply-To: <20151030193152.GI13239@google.com>
References: <1446188361-15146-1-git-send-email-anup.patel@broadcom.com>
 <20151030193152.GI13239@google.com>
Message-ID: <39063E8F96E11742B35A201CC5D095B7B063A5@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace at gmail.com]
> Sent: 31 October 2015 01:02
> To: Anup Patel
> Cc: David Woodhouse; Linux MTD; Rob Herring; Pawel Moll; Mark Rutland;
> Catalin Marinas; Will Deacon; Sudeep Holla; Ian Campbell; Kumar Gala; Ray Jui;
> Scott Branden; Florian Fainelli; Pramod Kumar; Vikram Prakash; Sandeep
> Tripathy; Linux ARM Kernel; Device Tree; Linux Kernel; bcm-kernel-feedback-list
> Subject: Re: [PATCH v5 0/3] NAND support for Broadcom NS2 SoC
> 
> On Fri, Oct 30, 2015 at 12:29:18PM +0530, Anup Patel wrote:
> > We enable NAND support for Broadcom NS2 SoC by reusing existing
> > BRCMNAND driver.
> >
> > This patchset applies on-top of "arm64: Simple additions to
> > NS2 DT" v1 patchset and is available in ns2_nand_v5 branch of
> > https://github.com/Broadcom/arm64-linux.git.
> >
> > The patchset is tested on NS2 SVK.
> 
> Applied patches 1 and 2. My "Reviewed-by" on patch 3 stands.
> 

Thanks Brian.

Regards,
Anup
