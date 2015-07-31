From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 18:56:55 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: dts: sun7i: Add dts file for
 Wits Pro A20 DKT
In-Reply-To: <CAGb2v65TEogqYFAfen1VnOaiepvez5t8Oh+Q=OYsRS_aZUMO3A@mail.gmail.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-6-git-send-email-hdegoede@redhat.com>
 <20150731102028.GE2564@lukather>
 <CAGb2v65TEogqYFAfen1VnOaiepvez5t8Oh+Q=OYsRS_aZUMO3A@mail.gmail.com>
Message-ID: <20150731165655.GG2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:25:29PM +0800, Chen-Yu Tsai wrote:
> > Note that it's a bit of a pain for now to support such cases, as
> > there's nothing to tie something from the DT to an SDIO device. I
> > don't have a better solution than marking it always-on at the moment,
> > with a big FIXME comment on top... :/
> 
> One could use the mmc-pwr-seq stuff. I don't know if it has been
> extended for multiple GPIOs, not that you would need it in this use
> case.

It doesn't really improve the situation. It doesn't handle the
regulators, it doesn't allow the real driver to get its resources
either, basically, it's just a hack.

> Maybe we ought to fix up the other ones, like the CubieTruck and A31
> Hummingbird?

I'll do it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/f889f8e0/attachment.sig>
