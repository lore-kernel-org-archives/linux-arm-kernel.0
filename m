From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Jul 2015 04:46:59 -0700
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20150707074626.GB12087@pali>
References: <20141019090107.GA19132@amd> <20141028222123.GA17518@amd>
 <20141028222641.GW2542@atomide.com> <201507061524.44999@pali>
 <20150706135317.GH10705@atomide.com> <20150707074626.GB12087@pali>
Message-ID: <20150707114658.GT10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150707 00:48]:
> On Monday 06 July 2015 06:53:18 Tony Lindgren wrote:
> > * Pali Roh?r <pali.rohar@gmail.com> [150706 06:27]:
> > > On Tuesday 28 October 2014 23:26:41 Tony Lindgren wrote:
> > > > * Pavel Machek <pavel@ucw.cz> [141028 15:22]:
> > > > > On Tue 2014-10-28 23:04:50, Pavel Machek wrote:
> > > > > > 
> > > > > > Networking now works against 3.17-based kernel. Thanks!
> > > > > 
> > > > > It works on 3.18-rc1 kernel, too. (I had to hand-modify patch to
> > > > > apply to 3.17, no changes needed for 3.18-rc1.)
> > > > > 
> > > > > Tested-by: Pavel Machek <pavel@ucw.cz>
> > > > 
> > > > Whatever we decice to do to fix this regression, it should probably
> > > > be backported to at least v3.16 stable for distro use, maybe earlier
> > > > too. I'd assume this is broken on multiple platforms currently.
> > > > 
> > > it looks like this patch was not included into any kernel version... I'm 
> > > still using it on top of 4.x kernels. Are you going to send this patch 
> > > into upstream? Or do you have another fix for this problem?
> > 
> > I think Felipe mentioned a better built-in gether fix that's been
> > reviewed on linux-usb list.
> 
> Do you have link to that email thread? Or was Felipe's fix already
> merged into mainline kernel?

Sorry I don't have a link, maybe Felipe can point you to the right
patch.

Regards,

Tony
