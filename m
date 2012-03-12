From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Mon, 12 Mar 2012 09:11:50 +0100
Subject: [PATCH 2/4] Add imx3sound sound support.
In-Reply-To: <CAOMZO5DP4P9Lq-gH_NNtDxwf8DxVAVg9MWHKr1E3RoexOgNYnQ@mail.gmail.com>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
 <CAOMZO5DP4P9Lq-gH_NNtDxwf8DxVAVg9MWHKr1E3RoexOgNYnQ@mail.gmail.com>
Message-ID: <4989193.ghnyrmjmJD@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le dimanche 11 mars 2012 11:59:40 Fabio Estevam a ?crit :
> On Fri, Mar 9, 2012 at 11:55 AM, Philippe R?tornaz
> 
> <philippe.retornaz@epfl.ch> wrote:
> > --- /dev/null
> > +++ b/sound/soc/imx/imx3sound-mc13783.c
> > @@ -0,0 +1,141 @@
> > +/*
> > + * imx3sound-mc13783.c  --  SoC audio for imx31_3ds based boards
> 
> Please rename this file to  "imx-mc13783.c".
> 
> mx27pdk board also has a mc13783 and will use this file.
> 
> It is not restricted to mx3 boards.

Ok, will do.

Thanks,

Philippe
