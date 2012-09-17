From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 17 Sep 2012 10:03:45 -0300
Subject: [PATCH 2/2] ARM: dts: imx23-olinuxino: Add USB host support
In-Reply-To: <20120917064643.GD6413@S2101-09.ap.freescale.net>
References: <1347557619-17793-1-git-send-email-fabio.estevam@freescale.com>
 <1347557619-17793-2-git-send-email-fabio.estevam@freescale.com>
 <20120917064643.GD6413@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5C2GEi6FjKmSS07Y0KOuF8H381Ju0W9DMmureG0xjfR_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 3:46 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The indentation needs a fix.

Ok, just fixed it in v2.

>
>> +                     enable-active-high;
>> +                     startup-delay-us = <300>; /* LAN9215 requires a POR of 200us minimum */
>
> So the regulator also supplies LAN9215?

On this board the VBUS is generated from LAN9215.

Regards,

Fabio Estevam
