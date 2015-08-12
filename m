From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Aug 2015 09:52:16 -0500
Subject: [RFC/PATCH-v4.2-rc6 2/5] arm: boot: dts: am4372: add ARM timers
 and SCU nodes
In-Reply-To: <20150812072816.GR4215@atomide.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-3-git-send-email-balbi@ti.com>
 <20150812072816.GR4215@atomide.com>
Message-ID: <20150812145216.GB13884@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:28:16AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [150810 14:44]:
> > AM437x devices sport SCU, TWD and Global timers,
> > let's add them to DTS so they have a chance to
> > probe and be used by Linux.
> 
> Is this one safe to apply already without the Kconfig change?
> 
> Or will it cause multi_v7_defconfig with the timers selected
> to not boot properly?

I'd have to try :-) But it should be safe, just the timers won't be
chosen for anything :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/adb93b17/attachment.sig>
