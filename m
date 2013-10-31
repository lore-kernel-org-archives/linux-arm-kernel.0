From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 31 Oct 2013 12:49:38 +0100
Subject: [PATCH 06/12] i2c: sh_mobile: Convert to clk_prepare/unprepare
In-Reply-To: <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131031114937.GA3431@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 11:49:23PM +0100, Laurent Pinchart wrote:
> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/e7f337c0/attachment.sig>
