From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 00:10:35 +0800
Subject: [PATCH 15/16] ARM: fiq: save FIQ_START by passing absolute fiq
 number
In-Reply-To: <20120620225520.GA30087@n2100.arm.linux.org.uk>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-16-git-send-email-shawn.guo@linaro.org>
 <20120618143128.GF19249@S2101-09.ap.freescale.net>
 <20120618164402.GA18630@n2100.arm.linux.org.uk>
 <20120619052654.GC21951@S2101-09.ap.freescale.net>
 <20120620225520.GA30087@n2100.arm.linux.org.uk>
Message-ID: <20120625161032.GG2342@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 11:55:20PM +0100, Russell King - ARM Linux wrote:
> I was thinking about moving entirely away from any bits of genirq for
> this.  We shouldn't really be mixing these two things together by
> nabbing some of the IRQ numberspace for this.
> 
> Looking at this code, I'm thinking about taking this further, and
> santising the whole thing... though that's not going to be a quick
> change.

Would you mind giving a little more hints on how this should be done
properly?  Sorry for my dumb head.

-- 
Regards,
Shawn
