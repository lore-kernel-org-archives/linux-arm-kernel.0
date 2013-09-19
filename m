From: david.woodhouse@intel.com (Woodhouse, David)
Date: Thu, 19 Sep 2013 21:39:36 +0000
Subject: [GIT PULL] ARM: SoC fixes for 3.12-rc
In-Reply-To: <20130919194752.GA19975@quad.lixom.net>
References: <20130919194752.GA19975@quad.lixom.net>
Message-ID: <1379626776.753.164.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-19 at 12:47 -0700, Olof Johansson wrote:
> 
> - A fix for build breakage in the MTD subsystem for some PXA devices.
>   David Woodhouse has this patch in his for-next branch but has not been
>   responding to our requests to send it up so here it is.
>   I should have amended the commit message to describe the build failure for
>   CONFIG_OF=n setups, but forgot and now it's down in the stack of commits.

Thanks for pulling that in. Apologies for the screwup. 

We were were working on a better way to fix the litter of #ifdef
CONFIG_OF which wasn't ready for the merge window so I just left this
one out since it *appeared* to be entirely cosmetic.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130919/2c3d1b11/attachment.bin>
