From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Jul 2018 19:50:15 -0300
Subject: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
In-Reply-To: <20180717040651.641-1-andrew.smirnov@gmail.com>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5Dp5aTZF0drkD+QSRyX6qGxAe0yeYGUS8-v=FtJwA7=SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Tue, Jul 17, 2018 at 1:06 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> +/dts-v1/;
> +#include "vf610.dtsi"
> +
> +/ {
> +       model = "ZII VF610 SSMB SPU3 Board";
> +       compatible = "zii,vf610spu3", "zii,vf610dev", "fsl,vf610";

Looks good to me.

Just a minor comment: Is " "zii,vf610dev" really needed here?

Anyway:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
