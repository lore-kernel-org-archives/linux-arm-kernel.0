From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Fri, 16 Nov 2018 11:25:07 +0100
Subject: [PATCH] ASoC: imx-audmux: complete dt-bindings for imx6
In-Reply-To: <20181116025938.GH5829@dragon>
References: <20181105135802.30486-1-peron.clem@gmail.com>
 <20181116025938.GH5829@dragon>
Message-ID: <CAJiuCcerEanEobbi8zPb1-eb=zCJsDAbM=p6T64+wtuXjtaMTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, 16 Nov 2018 at 03:59, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Nov 05, 2018 at 02:58:02PM +0100, Cl?ment P?ron wrote:
> > From: Colin Didier <colin.didier@devialet.com>
> >
> > The MX6 Audmux differs from MX51.
> >
> > This patch adds the audmux for i.MX6 family.
> >
> > Signed-off-by: Colin Didier <colin.didier@devialet.com>
> > Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
>
> I think you should send it to ASoC maintainer and list for applying.

It's still quite new for me to submit patch, but if this patch should
be sent to ASoC maintainer maybe there is a line missing in the
MAINTAINERS file no ?

SOUND
M:      Jaroslav Kysela <perex@perex.cz>
M:      Takashi Iwai <tiwai@suse.com>
L:      alsa-devel at alsa-project.org (moderated for non-subscribers)
W:      http://www.alsa-project.org/
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
T:      git git://git.alsa-project.org/alsa-kernel.git
Q:      http://patchwork.kernel.org/project/alsa-devel/list/
S:      Maintained
F:      Documentation/sound/
+ F:      include/dt-bindings/sound/
F:      include/sound/
F:      include/uapi/sound/
F:      sound/

Regards,
Clement

>
> Shawn
>
> > ---
> >  include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
> > index 15f138bebe16..a1d0741d9ed1 100644
> > --- a/include/dt-bindings/sound/fsl-imx-audmux.h
> > +++ b/include/dt-bindings/sound/fsl-imx-audmux.h
> > @@ -25,6 +25,14 @@
> >  #define MX51_AUDMUX_PORT6            5
> >  #define MX51_AUDMUX_PORT7            6
> >
> > +#define MX6_AUDMUX_PORT1_SSI1                0
> > +#define MX6_AUDMUX_PORT2_SSI2                1
> > +#define MX6_AUDMUX_PORT3             2
> > +#define MX6_AUDMUX_PORT4             3
> > +#define MX6_AUDMUX_PORT5             4
> > +#define MX6_AUDMUX_PORT6             5
> > +#define MX6_AUDMUX_PORT7_SSI3                6
> > +
> >  /*
> >   * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
> >   * can be sourced from Rx/Tx.
> > --
> > 2.19.1
> >
