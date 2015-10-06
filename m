From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Oct 2015 10:37:28 +0200
Subject: [PATCH RESEND] ARM: dts: Fix Makefile target for
 sun4i-a10-itead-iteaduino-plus
In-Reply-To: <1444085717.2956.0.camel@decadent.org.uk>
References: <20150904124934.GD464@hansolo.redhat.com>
 <20150906112046.GK31584@lukather>
 <1444085717.2956.0.camel@decadent.org.uk>
Message-ID: <20151006083728.GQ2696@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 11:55:17PM +0100, Ben Hutchings wrote:
> On Sun, 2015-09-06 at 13:20 +0200, Maxime Ripard wrote:
> > On Fri, Sep 04, 2015 at 08:49:34AM -0400, Josh Boyer wrote:
> > > Commit 79ae3e66f8d (ARM: dts: sun4i: Add Iteaduino Plus A10) added a new
> > > make target for the sun4i-a10-itead-iteaduino-plus dts file, but mistakenly
> > > used .dts instead of the correct .dtb suffix.  This resulted in a build error
> > > like:
> > > 
> > >         scripts/Makefile.dtbinst:42: target 'sun4i-a10-itead-iteaduino-plus.dts' doesn't match the target pattern
> > > 
> > > when doing a make dtbs_install.
> > > 
> > > Fix it to use the proper file name.
> > > 
> > > Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> > 
> > Queued, thanks!
> 
> This still isn't in Linus's tree; please make sure it gets to him
> before 4.3.

The pull request has been sent on sunday to arm-soc.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/bb45db07/attachment.sig>
