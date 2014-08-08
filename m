From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 8 Aug 2014 11:46:55 +0200
Subject: [PATCH v2 06/11] pwm: sti: Add new driver for ST's PWM IP
In-Reply-To: <20140808073802.GC21618@lee--X1>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
 <1405348412-7352-7-git-send-email-lee.jones@linaro.org>
 <20140807142344.GA11095@ulmo.nvidia.com>
 <20140808073802.GC21618@lee--X1>
Message-ID: <20140808094655.GC15852@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 08:38:02AM +0100, Lee Jones wrote:
> On Thu, 07 Aug 2014, Thierry Reding wrote:
> > On Mon, Jul 14, 2014 at 03:33:27PM +0100, Lee Jones wrote:
> > [...]
> > > +static int sti_pwm_probe(struct platform_device *pdev)
> > > +{
> > [...]
> > > +	pc->clk = of_clk_get_by_name(np, "pwm");
> > 
> > This didn't compile because the np variable isn't declared. It was easy
> > to fix up, so I did, but please be more careful next time that the
> > patches you submit at least compile (preferably without sparse warnings
> > of which I also fixed up a couple).
> 
> That's annoying, I thought I did build test the final changes.
> However, there's a mistake in the Makefile meaning that it wasn't
> building with no warning/error messages - it actually wasn't building
> at all!  Sorry about that Thierry.
> 
> I guess if you can build the driver, you've already fixed that?

Yes, it should be all taken care of in the PWM for-next branch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140808/cb51864b/attachment-0001.sig>
