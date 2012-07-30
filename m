From: B37400@freescale.com (Singh Sandeep-B37400)
Date: Mon, 30 Jul 2012 09:29:15 +0000
Subject: [2/3][PATCH][v2] TDM Framework
In-Reply-To: <20498.41365.853741.261834@quad.stoffel.home>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20498.41365.853741.261834@quad.stoffel.home>
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511095@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----Original Message-----
From: John Stoffel [mailto:john at stoffel.org] 
Sent: 27 July 2012 19:42
To: Singh Sandeep-B37400
Cc: linuxppc-dev at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; galak at kernel.crashing.org; linux-kernel at vger.kernel.org; devel at driverdev.osuosl.org
Subject: Re: [2/3][PATCH][v2] TDM Framework


> From: Sandeep Singh <Sandeep@freescale.com> TDM Framework is an 
> attempt to provide a platform independent layer which can offer a 
> standard interface  for TDM access to different client modules.

Please don't use TLAs (Three Letter Acronyms) like TDM without explaining the clearly and up front.  It makes it hard for anyone else who doens't know your code to look it over without having to spend lots of time poking around to figure it out from either context or somewhere else.
[Sandeep] Patch for documentation for TDM is present in this patch set, which explains TDM in detail. Should we do this in commit message too??
Link too documentation patch: http://patchwork.ozlabs.org/patch/173680/

John
