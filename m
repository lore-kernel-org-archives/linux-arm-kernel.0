From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 16 May 2013 17:22:58 +0100
Subject: [PATCH] ARM: remove the .vm_mm value from gate_vma.
In-Reply-To: <20130516143638.GR18614@n2100.arm.linux.org.uk>
References: <1368702394-1737-1-git-send-email-steve.capper@linaro.org>
 <20130516143638.GR18614@n2100.arm.linux.org.uk>
Message-ID: <20130516162257.GA7521@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 03:36:38PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 16, 2013 at 12:06:34PM +0100, Steve Capper wrote:

[ ... ]

> 
> This looks fine - x86 also sets .vm_mm to NULL here.  So please put
> it in my patch system.  Does this need to be applied to stable
> kernels as well?  If so, please mark it with Cc: <stable@vger.kernel.org>
> (but do not send it to that address).  Also, it'd be worth checking
> which stable kernels it needs to be applied to.
> 
> Thanks.

Thank you Russell,
I couldn't see any branches in linux-stable that need this patch.
The patch is now in your system with id 7727/1.

Cheers,
-- 
Steve
