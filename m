From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 2 Sep 2013 11:33:10 +0100
Subject: [PATCH V3 RFC 00/16] EFI stub for ARM
In-Reply-To: <CAFECyb_OMY6eEbkbYTC4sE56Za0rC+KFNFRbGWb2ECEqhiKbTQ@mail.gmail.com>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <CAFECyb_OMY6eEbkbYTC4sE56Za0rC+KFNFRbGWb2ECEqhiKbTQ@mail.gmail.com>
Message-ID: <20130902103310.GF28598@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Aug, at 10:58:16AM, Roy Franz wrote:
> Hi Matt,
> 
>    Do you have any more feedback on the X86 and common code (patches
> 1-13) that needs to be addressed?  Mark Salter has a working ARM64 EFI
> stub implemented based on these patches, so the common code has now
> been tested with another architecture, and he has acked these patches.
> If the current patches are OK, can this be queued for 3.12? (and into
> linux-next, if appropriate)
> The ARM portion may take a little longer based on the EFI runtime
> services patch dependencies, but getting the common code merged would
> allow the ARM64 EFI stub work to go forward independently.
> 
> I can resend patches 1-13 as a new series of x86/common only changes
> if you would like.

I think resending the common patches as a new series, including Acked-by
and Reviewed-by tags, and after addressing Grant's comments is the best
idea.

We've missed the v3.12 merge window now, but we can certainly get these
into linux-next for some testing.

-- 
Matt Fleming, Intel Open Source Technology Center
