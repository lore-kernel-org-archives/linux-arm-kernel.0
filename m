From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 16:26:08 +0200
Subject: [PATCH v5 03/46] backlight: lm3630a_bl: stop messing with the
 pwm->period field
In-Reply-To: <20160412141613.GI8094@x1>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110809.GI18882@ulmo.ba.sec> <20160412141613.GI8094@x1>
Message-ID: <20160412142608.GB25006@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 03:16:13PM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
> 
> > On Wed, Mar 30, 2016 at 10:03:26PM +0200, Boris Brezillon wrote:
> > > pwm->period field is not supposed to be changed by PWM users. The only
> > > ones authorized to change it are the PWM core and PWM drivers.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  drivers/video/backlight/lm3630a_bl.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > Applied, thanks.
> 
> Applied?

You didn't specifically Ack this one, but I presumed that since the
change is essentially the same as for pwm-backlight, and this is another
prerequisite for the remainder of the series it should go in through the
PWM tree as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/bf31114a/attachment.sig>
