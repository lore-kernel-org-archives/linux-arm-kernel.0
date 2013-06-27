From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Thu, 27 Jun 2013 18:28:17 +0100
Subject: [PATCH 1/4] Documentation: arm: [U]EFI runtime services
In-Reply-To: <1372345790.2522.26.camel@dabdike>
References: <51CA2B03.4080106@wwwdotorg.org>
 <CACxGe6vsBKnbipR-Zd1T9Ox1J2ugFmShrGXGUzPa_=D9TJvFQw@mail.gmail.com>
 <20130626135311.GA9078@rocoto.smurfnet.nu>
 <20130626135933.GQ22026@console-pimps.org>
 <1372257499.2168.5.camel@dabdike>
 <20130627013219.GA346@srcf.ucam.org>
 <CACxGe6uFkbuJ3BxM=A0Lu=jZQ79Ba8SmNsdBdTOO13szTfTZ=Q@mail.gmail.com>
 <1372314821.557.33.camel@dabdike>
 <20130627143714.GA12900@srcf.ucam.org>
 <1372345790.2522.26.camel@dabdike>
Message-ID: <20130627172817.GB16316@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 08:09:50AM -0700, James Bottomley wrote:
> On Thu, 2013-06-27 at 15:37 +0100, Matthew Garrett wrote:
> > And yet it's the only mode in which the firmrware is actually tested 
> > against an OS, so we don't have any real choice in the matter.
> 
> Agree for x86 ... we just have to cope with the implementations we see
> in the field.  However, ARM has much more scope to have the UEFI
> implementation developed collaboratively with Linux as the reference
> platform.  If we can convince the ARM implementors that
> SetVirtualAddressMap is an accident waiting to happen, they might be
> more flexible.

The majority of existing ARM UEFI implementations have only ever been 
used to boot Windows, so like I said, this really isn't a safe 
assumption.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
