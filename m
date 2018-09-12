From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 12 Sep 2018 22:53:50 +0800
Subject: [PATCH RESEND] drivers: soc: Allow building the sunxi driver
 without ARCH_SUNXI
In-Reply-To: <20180910114311.6fw3iwend3js7mcf@flea>
References: <20180909190439.20425-1-contact@paulk.fr>
 <20180910114311.6fw3iwend3js7mcf@flea>
Message-ID: <CAGb2v658HmGX0WfoDR_uv7+SFigchOtJAOU=VrTgFy5aAoV1HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 7:43 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Sep 09, 2018 at 09:04:39PM +0200, Paul Kocialkowski wrote:
> > This makes it possible to build the sunxi SRAM driver without building
> > for the sunxi architecture. This allows selecting the driver when
> > building the kernel in testing environments.
> >
> > In particular, this is necessary for testing of the Cedrus driver, that
> > selects the sunxi SRAM driver.
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied for 4.20.

ChenYu
