From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 21 Jul 2011 08:37:45 -0700
Subject: [PATCH 1/2] ARM: Tegra: Seaboard board updates for audio
In-Reply-To: <CAOesGMjiakgvs8wcu8zRkuA9mxD5Z=S-hV3HNgqFC49pEGVADw@mail.gmail.com>
References: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
	<CAOesGMjiakgvs8wcu8zRkuA9mxD5Z=S-hV3HNgqFC49pEGVADw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF13E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, July 13, 2011 5:17 PM:
> On Wed, Jul 13, 2011 at 2:57 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > * Initialize clock tree for audio
> > * Add GPIO base definitions
> > * Add audio GPIO definitions
> > * Define platform data for WM8903 and ASoC machine driver
> > * Add special case for Kaen to handle HP_MUTE GPIO
> > * Register platform devices for audio
> > * Update pinmux to cater for new GPIOs used for audio
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> Colin, sounds like you're collecting board patches this merge window, so:
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Colin,

Do you want me to ask Arnd to pick these patches up directly, or do you
want to apply them to the Tegra for-next tree, and have Arnd pull them?

Thanks.

-- 
nvpublic
