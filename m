From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 19:02:01 +0200
Subject: [PATCH v4 3/8] Documentation: devicetree: rockchip: Document
 GeekBox
In-Reply-To: <1682289.HWd4yLL18I@diego>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <56FAE95E.6060900@suse.de> <1682289.HWd4yLL18I@diego>
Message-ID: <1913373.6hKqMKImXt@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 29. M?rz 2016, 23:21:51 schrieb Heiko St?bner:
> Am Dienstag, 29. M?rz 2016, 22:45:18 schrieb Andreas F?rber:
> > Am 29.03.2016 um 22:13 schrieb Heiko St?bner:
> > > Am Mittwoch, 16. M?rz 2016, 14:58:41 schrieb Andreas F?rber:
> > >> Use "geekbuying,geekbox" compatible string.
> > >> 
> > >> Acked-by: Rob Herring <robh@kernel.org>
> > >> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > > 
> > > I've folded this patch into the geekbox dts patch, carrying Rob's Ack
> > > for
> > > the binding over.
> > 
> > Either you just made a mistake in my name or
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Do
> > cume ntation/devicetree/bindings/submitting-patches.txt needs an update.
> > It clearly says:
> > 
> > "1) The Documentation/ portion of the patch should be a separate patch."
> > 
> > That's why I always do it this way.
> 
> looking at the dt-bindings git log, it seems that is handled in a variety
> of ways :-) . Personally I'm doing completely new bindings separately but
> the 125th addition of a board just inside the dts patch.
> 
> But I guess we can also move it out again into a separate patch if you
> prefer that :-) .

I've split out that documentation addition again and applied this separate 
patch instead :-) .


Heiko
