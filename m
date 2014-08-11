From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Aug 2014 17:02:22 +0100
Subject: [RESEND PATCH 2/2] ARM: dts: Add tps65090 FET constraints on
 Peach Pit and Pi
In-Reply-To: <CAD=FV=XRmNkxXoxWaEfxFADrTgBrOPVX746woxiZoKck1ajwgA@mail.gmail.com>
References: <1407757091-18730-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407757091-18730-2-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=XRmNkxXoxWaEfxFADrTgBrOPVX746woxiZoKck1ajwgA@mail.gmail.com>
Message-ID: <20140811160222.GF17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 08:57:24AM -0700, Doug Anderson wrote:
> On Mon, Aug 11, 2014 at 4:38 AM, Javier Martinez Canillas

> > After the switch is turned on, a safety timer is started
> > and before this timer times out the output voltage must
> > have reached the input voltage. Otherwise the switch is
> > turned off expecting an overload condition.

> > So using the maximum output voltage slew rate and the timer
> > minimum and maximum timeouts, a voltage constraints can be
> > expressed as bounded limits for the timeout. That is what
> > is used in the board schematics and should be in the DT too.

> I don't understand this, but if you and Mark are happy with it...

I have not looked at this change to my knowledge.

> ...I'm also not 100% certain what the above description has to do with
> this change, but I'll admit to having only skimmed some of the earlier
> conversations.

It's not at all clear to me either looking at the quoted section.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140811/a491d7bd/attachment.sig>
