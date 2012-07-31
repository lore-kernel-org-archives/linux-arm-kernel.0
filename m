From: B37400@freescale.com (Singh Sandeep-B37400)
Date: Tue, 31 Jul 2012 06:40:31 +0000
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <20502.38341.619003.356462@quad.stoffel.home>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20498.41365.853741.261834@quad.stoffel.home>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E511095@039-SN1MPN1-006.039d.mgd.msft.net>
 <20502.38341.619003.356462@quad.stoffel.home>
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511B76@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----Original Message-----
From: John Stoffel [mailto:john at stoffel.org] 
Sent: Monday, July 30, 2012 7:40 PM
To: Singh Sandeep-B37400
Cc: John Stoffel; linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; galak at kernel.crashing.org; linux-kernel at vger.kernel.org; devel at driverdev.osuosl.org
Subject: RE: [2/3][PATCH][v2] TDM Framework

>>>>> "Singh" == Singh Sandeep-B37400 <B37400@freescale.com> writes:

Singh> -----Original Message-----
Singh> From: John Stoffel [mailto:john at stoffel.org]
Singh> Sent: 27 July 2012 19:42
Singh> To: Singh Sandeep-B37400
Singh> Cc: linuxppc-dev at lists.ozlabs.org; 
Singh> linux-arm-kernel at lists.infradead.org; galak at kernel.crashing.org; 
Singh> linux-kernel at vger.kernel.org; devel at driverdev.osuosl.org
Singh> Subject: Re: [2/3][PATCH][v2] TDM Framework


>> From: Sandeep Singh <Sandeep@freescale.com> TDM Framework is an 
>> attempt to provide a platform independent layer which can offer a 
>> standard interface  for TDM access to different client modules.

Singh> Please don't use TLAs (Three Letter Acronyms) like TDM without explaining the clearly and up front.  It makes it hard for anyone else who doens't know your code to look it over without having to spend lots of time poking around to figure it out from either context or somewhere else.

Singh> [Sandeep] Patch for documentation for TDM is present in this 
Singh> patch set, which explains TDM in detail. Should we do this in 
Singh> commit message too??  Link too documentation patch:
Singh> http://patchwork.ozlabs.org/patch/173680/

You should put the expansion of TDM into the initial commit message, and also into the Kconfig text, so that someone configuring the kernel has a clue what you're talking about.  
[Sandeep] Thanks for suggestion. Will take care.

Try to approach this as a brandnew user who doesn't have your knowledge of the software.  Write for the un-initiated if at all possible.


John
