From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 02 May 2013 14:49:22 -0400
Subject: [PATCH 2/3] xen: move do_stolen_accounting to drivers/xen/time.c
In-Reply-To: <1367436460-10183-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <5182B532.10607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 05/01/2013 03:27 PM, Stefano Stabellini wrote:
> Move do_stolen_accounting, xen_vcpu_stolen and related functions and
> static variables to common code (drivers/xen/time.c).
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  arch/x86/xen/time.c   |  127 +-------------------------------------------

In going through some of the code, it looked like there might be a few little
bits that you might be interested in pulling out of arch/ia64/xen/time.c as well.

[...]

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
