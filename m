From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Nov 2014 10:30:23 +0000
Subject: [PATCH] ARM: Update processor_modes for hyp and monitor mode
In-Reply-To: <54768461.3050501@codeaurora.org>
References: <1416272732-20573-1-git-send-email-sboyd@codeaurora.org>
 <54768461.3050501@codeaurora.org>
Message-ID: <20141127103023.GM3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:54:41PM -0800, Stephen Boyd wrote:
> On 11/17/2014 05:05 PM, Stephen Boyd wrote:
> >If the kernel is running in hypervisor mode or monitor mode we'll
> >print UK6_32 or UK10_32 if we call into __show_regs(). Let's
> >update these strings to indicate the new modes that didn't exist
> >when this code was written.
> >
> >Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> >---
> 
> Can I throw this into the patch tracker?

Yep.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
