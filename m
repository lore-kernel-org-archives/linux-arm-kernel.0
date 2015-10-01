From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Oct 2015 12:11:56 +0200
Subject: [PATCH RESEND] ARM: dts: Fix Makefile target for
 sun4i-a10-itead-iteaduino-plus
In-Reply-To: <CA+5PVA5ceg94PrUdUpb5X7ZsbEuK4_u1V-ZDesR7h_MZ8rGUtg@mail.gmail.com>
References: <20150904124934.GD464@hansolo.redhat.com>
 <20150906112046.GK31584@lukather>
 <CA+5PVA5ceg94PrUdUpb5X7ZsbEuK4_u1V-ZDesR7h_MZ8rGUtg@mail.gmail.com>
Message-ID: <20151001101156.GE7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 29, 2015 at 10:32:59AM -0400, Josh Boyer wrote:
> On Sun, Sep 6, 2015 at 7:20 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, Sep 04, 2015 at 08:49:34AM -0400, Josh Boyer wrote:
> >> Commit 79ae3e66f8d (ARM: dts: sun4i: Add Iteaduino Plus A10) added a new
> >> make target for the sun4i-a10-itead-iteaduino-plus dts file, but mistakenly
> >> used .dts instead of the correct .dtb suffix.  This resulted in a build error
> >> like:
> >>
> >>         scripts/Makefile.dtbinst:42: target 'sun4i-a10-itead-iteaduino-plus.dts' doesn't match the target pattern
> >>
> >> when doing a make dtbs_install.
> >>
> >> Fix it to use the proper file name.
> >>
> >> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> >
> > Queued, thanks!
> 
> Are you going to push this to Olof or Linus for the 4.3 release?  I
> don't see it in Linus' tree and this is still broken there.

I was planning on sending the pull request for 4.3 sometime this week.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/a4f517e4/attachment.sig>
