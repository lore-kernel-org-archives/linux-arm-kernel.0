From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Thu, 9 Jun 2011 09:53:18 +0300
Subject: [PATCH] ARM: tegra/harmony: enable USB host ports
In-Reply-To: <4DEFADCB.90805@arm.com>
References: <1307528018-14454-1-git-send-email-marc.zyngier@arm.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498E1CDC5@HQMAIL01.nvidia.com>
	<4DEFADCB.90805@arm.com>
Message-ID: <BANLkTikRZw+OjUit=uLpHYS1KkPeM2FbEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 8:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> > I'm not sure if that platform data is appropriate for tegra_ehci1_device;
> > the ChromeOS kernel doesn't enable that port.
>
> There's probably some kind of GPIO trickery involved to reset the port...

I don't think it's possible to enable port 1 in host mode on
harmony... As far as I remember, port 1 is routed to mini-B connector
and there's nothing that would supply Vbus in the host mode...

> > You can find that at either:
> >
> > http://git.chromium.org/chromiumos/third_party/kernel.git
> >
> > or commit 0d7ae83b763bb3727e6b6189b49925cd3ab2e204
> > http://avon.wwwdotorg.org/downloads/kernel.git asoc_for-2.6.40_plus_harmony
>
> Thanks for the pointers.
>
> Cheers,
>
> ? ? ? ?M.
> --
> Jazz is not dead. It just smells funny...
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html



--
Sincerely Yours,
Mike.
