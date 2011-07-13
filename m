From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Jul 2011 16:17:06 -0700
Subject: [PATCH 1/2] ARM: Tegra: Seaboard board updates for audio
In-Reply-To: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
References: <1310594272-8229-1-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMjiakgvs8wcu8zRkuA9mxD5Z=S-hV3HNgqFC49pEGVADw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 2:57 PM, Stephen Warren <swarren@nvidia.com> wrote:
> * Initialize clock tree for audio
> * Add GPIO base definitions
> * Add audio GPIO definitions
> * Define platform data for WM8903 and ASoC machine driver
> * Add special case for Kaen to handle HP_MUTE GPIO
> * Register platform devices for audio
> * Update pinmux to cater for new GPIOs used for audio
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Colin, sounds like you're collecting board patches this merge window, so:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
