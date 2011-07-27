From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 27 Jul 2011 11:04:28 -0400 (EDT)
Subject: [PATCHv3 2/2] ARM: P2V: Remove ARM_PATCH_PHYS_VIRT_16BIT
In-Reply-To: <20110727145330.GA32004@huya.qualcomm.com>
References: <1311733255-25207-1-git-send-email-sboyd@codeaurora.org>
	<1311733255-25207-2-git-send-email-sboyd@codeaurora.org>
	<20110727145330.GA32004@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1107271102370.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jul 2011, David Brown wrote:

> On Tue, Jul 26, 2011 at 07:20:55PM -0700, Stephen Boyd wrote:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > Now that MSM targets no longer need the 16-bit offsets for P2V, this
> > code can be removed.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I've tested this on MSM, but without an actual offset.  It'd be good
> to test this on a target with an actual adjustment being used, to make
> sure nothing breaks.

Unless your RAM is physically located at 0xc0000000, you do end up 
having an offset already.


Nicolas
