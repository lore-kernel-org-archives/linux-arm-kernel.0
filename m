From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Aug 2015 14:54:01 -0500
Subject: [RFC/PATCH-v4.2-rc6 2/5] arm: boot: dts: am4372: add ARM timers
 and SCU nodes
In-Reply-To: <20150812145216.GB13884@saruman.tx.rr.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-3-git-send-email-balbi@ti.com>
 <20150812072816.GR4215@atomide.com>
 <20150812145216.GB13884@saruman.tx.rr.com>
Message-ID: <20150812195401.GB20972@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 12, 2015 at 09:52:16AM -0500, Felipe Balbi wrote:
> On Wed, Aug 12, 2015 at 12:28:16AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [150810 14:44]:
> > > AM437x devices sport SCU, TWD and Global timers,
> > > let's add them to DTS so they have a chance to
> > > probe and be used by Linux.
> > 
> > Is this one safe to apply already without the Kconfig change?
> > 
> > Or will it cause multi_v7_defconfig with the timers selected
> > to not boot properly?
> 
> I'd have to try :-) But it should be safe, just the timers won't be
> chosen for anything :-)

Just booted with only $subject and patch 1/5, it works just fine.

I'll resend the series (now, 4 patches only) and if RMK is fine with
patch 1, then I'll add to his patch system.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/a8b0a932/attachment.sig>
