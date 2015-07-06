From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 6 Jul 2015 15:24:44 +0200
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141028222641.GW2542@atomide.com>
References: <20141019090107.GA19132@amd> <20141028222123.GA17518@amd>
 <20141028222641.GW2542@atomide.com>
Message-ID: <201507061524.44999@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 23:26:41 Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [141028 15:22]:
> > On Tue 2014-10-28 23:04:50, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Here's a patch that should fix the issues for built-in USB
> > > > gadgets.
> > > > 
> > > > Pavel, care to see if this gets NFSroot over USB working again
> > > > for you?
> > > 
> > > It seems to have did the trick for me. (Plus I needed to add
> > > 
> > > +CONFIG_ARM_ATAG_DTB_COMPAT=y
> > > +CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> > > +# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
> > > 
> > > to be able to control the command line, that's why testing took
> > > me a while.)
> > > 
> > > Networking now works against 3.17-based kernel. Thanks!
> > 
> > It works on 3.18-rc1 kernel, too. (I had to hand-modify patch to
> > apply to 3.17, no changes needed for 3.18-rc1.)
> > 
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> Whatever we decice to do to fix this regression, it should probably
> be backported to at least v3.16 stable for distro use, maybe earlier
> too. I'd assume this is broken on multiple platforms currently.
> 
> Regards,
> 
> Tony

Hi Tony,

it looks like this patch was not included into any kernel version... I'm 
still using it on top of 4.x kernels. Are you going to send this patch 
into upstream? Or do you have another fix for this problem?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/bd2c4fd3/attachment.sig>
