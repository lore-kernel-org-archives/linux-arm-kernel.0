From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 05 Oct 2015 23:55:17 +0100
Subject: [PATCH RESEND] ARM: dts: Fix Makefile target for
 sun4i-a10-itead-iteaduino-plus
In-Reply-To: <20150906112046.GK31584@lukather>
References: <20150904124934.GD464@hansolo.redhat.com>
 <20150906112046.GK31584@lukather>
Message-ID: <1444085717.2956.0.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-09-06 at 13:20 +0200, Maxime Ripard wrote:
> On Fri, Sep 04, 2015 at 08:49:34AM -0400, Josh Boyer wrote:
> > Commit 79ae3e66f8d (ARM: dts: sun4i: Add Iteaduino Plus A10) added a new
> > make target for the sun4i-a10-itead-iteaduino-plus dts file, but mistakenly
> > used .dts instead of the correct .dtb suffix.  This resulted in a build error
> > like:
> > 
> >         scripts/Makefile.dtbinst:42: target 'sun4i-a10-itead-iteaduino-plus.dts' doesn't match the target pattern
> > 
> > when doing a make dtbs_install.
> > 
> > Fix it to use the proper file name.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> 
> Queued, thanks!

This still isn't in Linus's tree; please make sure it gets to him
before 4.3.

Ben.

-- 
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/b99f657c/attachment.sig>
