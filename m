From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 16:25:09 +0200
Subject: [PATCH v5 02/46] backlight: pwm_bl: remove useless call to
 pwm_set_period()
In-Reply-To: <20160412141653.GJ8094@x1>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110350.GH18882@ulmo.ba.sec> <20160412141653.GJ8094@x1>
Message-ID: <20160412142509.GA25006@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 03:16:53PM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
> 
> > On Wed, Mar 30, 2016 at 10:03:25PM +0200, Boris Brezillon wrote:
> > > The PWM period will be set when calling pwm_config. Remove this useless
> > > call to pwm_set_period(), which might mess up with the internal PWM state.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > Applied, thanks.
> 
> Applied?

You Acked it, so I assumed you were fine with me taking it through the
PWM tree to take care of the dependencies.

Did I assume wrongly?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/9025c97c/attachment.sig>
