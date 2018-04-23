From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 23 Apr 2018 14:24:44 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Fix incorrect clocks
 for displays
In-Reply-To: <887c9144972ab75a4520141a17e1607b@pascalroeleven.nl>
References: <20180420102112.2843-1-dev@pascalroeleven.nl>
 <20180423071421.byupsz4gxpmhfe44@flea>
 <887c9144972ab75a4520141a17e1607b@pascalroeleven.nl>
Message-ID: <20180423122444.msxpe5e4ovr6eqqb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 01:01:03PM +0200, Pascal Roeleven wrote:
> On 2018-04-23 09:14, Maxime Ripard wrote:
> > On Fri, Apr 20, 2018 at 12:21:12PM +0200, Pascal Roeleven wrote:
> > > Some displays on SUN4i devices wouldn't properly stay on unless
> > > 'clk_ignore_unused' is used.
> > > 
> > > Change the duplicate clocks to the probably intended ones.
> > > 
> > > Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> > 
> > What was the difference with the first patch you sent?
> > 
> > Anyway, I've applied it, thanks
> > 
> > Maxime
> > 
> > --
> > Maxime Ripard, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> I'm sorry there isn't any.
> It's the first patch I have ever send so had some git-send-email issues and
> didn't know the correct procedure to resend a patch.

Just set RESEND in the subject prefix (using --subject-prefix="PATCH
RESEND"), and say why you resent it in the patch / cover letter after
the --- and before the diffstat.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180423/0ef32c25/attachment.sig>
