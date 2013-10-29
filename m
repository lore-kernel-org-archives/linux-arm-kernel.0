From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 Oct 2013 14:58:07 +0900
Subject: [PATCH 06/12] i2c: sh_mobile: Convert to clk_prepare/unprepare
In-Reply-To: <20131029050224.GA2643@katana>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131029050224.GA2643@katana>
Message-ID: <20131029055807.GE11580@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 06:02:24AM +0100, Wolfram Sang wrote:
> On Mon, Oct 28, 2013 at 11:49:23PM +0100, Laurent Pinchart wrote:
> > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> > clk_disable_unprepare() to get ready for the migration to the common
> > clock framework.
> > 
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c at vger.kernel.org
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Hi Wolfram, Hi Laurent,

correct me if I am wrong, but I think the plan was
for Wolfram to take this patch.
