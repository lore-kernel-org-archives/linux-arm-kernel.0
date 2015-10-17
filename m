From: anup.patel@broadcom.com (Anup Patel)
Date: Sat, 17 Oct 2015 02:52:26 +0000
Subject: [PATCH v2 1/4] mtd: brcmnand: Fix pointer type-cast in
 brcmnand_write()
In-Reply-To: <56211976.1030401@broadcom.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
 <1444986537-28387-2-git-send-email-anup.patel@broadcom.com>
 <56211976.1030401@broadcom.com>
Message-ID: <39063E8F96E11742B35A201CC5D095B7AEE5AD@SJEXCHMB10.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Ray Jui [mailto:rjui at broadcom.com]
> Sent: 16 October 2015 21:06
> To: Anup Patel; David Woodhouse; Brian Norris; linux-mtd at lists.infradead.org
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Catalin
> Marinas; Will Deacon; Scott Branden; Florian Fainelli; Pramod Kumar; Vikram
> Prakash; Sandeep Tripathy; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; bcm-kernel-
> feedback-list
> Subject: Re: [PATCH v2 1/4] mtd: brcmnand: Fix pointer type-cast in
> brcmnand_write()
> 
> Correct me if I remember it wrong, but I thought this patch has already been
> merged by Brian?

Yes, patch1 and patch2 were merged by Brian. I realized this after I had
send-out v2. Anyways we can ignore patch1 and patch2 from this patchset
because they are same as v1.

Regards,
Anup
