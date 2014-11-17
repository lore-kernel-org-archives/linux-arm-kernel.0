From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 17 Nov 2014 16:21:53 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141117150617.GD7046@atomide.com>
References: <20141116075928.GA9763@amd> <201411171601.32311@pali>
 <20141117150617.GD7046@atomide.com>
Message-ID: <201411171621.54895@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 November 2014 16:06:17 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141117 07:03]:
> > On Monday 17 November 2014 15:55:46 Tony Lindgren wrote:
> > > There's nothing stopping us from initializing the camera
> > > code from pdata-quirks.c for now to keep it working.
> > > Certainly the binding should be added to the driver, but
> > > that removes a dependency to the legacy booting mode if
> > > things are otherwise working.
> > 
> > Tony, legacy board code for n900 is not in mainline tree.
> > And that omap3 camera subsystem for n900 is broken since
> > 3.5 kernel... (both Front and Back camera on n900 show only
> > green picture).
> 
> I'm still seeing the legacy board code for n900 in mainline
> tree :) It's deprecated, but still there.
> 

Yes, it is there because conversion from board code to DT is not 
complete yet... It is slow progress but you can watch it on page 
http://elinux.org/N900 (last two columns).

> Are you maybe talking about some other piece of platform_data
> that's no longer in the mainline kernel?
> 

Yes, about platform_data which were never in mainline kernel. 
Just only in other trees. That code is: camera subsystem (with 
all other devices), cellular modem, bluetooth, radio.

> No idea what might be wrong with the camera though.
> 
> Regards,
> 
> Tony

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/a510ac35/attachment.sig>
