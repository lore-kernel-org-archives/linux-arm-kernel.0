From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 26 Jun 2012 11:57:03 +0200
Subject: [PATCH 2/4] pwm: pwm-mxs: use global reset function
 stmp_reset_block
In-Reply-To: <20120626095456.GA8687@avionic-0098.mockup.avionic-design.de>
References: <1340701091-8488-1-git-send-email-shawn.guo@linaro.org>
 <1340701091-8488-3-git-send-email-shawn.guo@linaro.org>
 <20120626095456.GA8687@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120626095703.GA20185@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:54:56AM +0200, Thierry Reding wrote:
> On Tue, Jun 26, 2012 at 04:58:09PM +0800, Shawn Guo wrote:
> > Use global reset function stmp_reset_block instead of mxs_reset_block
> > to remove <mach/common.h> inclusion.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/pwm/pwm-mxs.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Doesn't this need a depends on/select STMP_DEVICE?

Upon closer investigation, select STMP_DEVICE seems to be correct.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/9e34ec72/attachment.sig>
