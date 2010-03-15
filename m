From: martinwguy@gmail.com (Martin Guy)
Date: Mon, 15 Mar 2010 19:44:27 +0000
Subject: [PATCH 2/3] ep93xx: added chip revision reading function
In-Reply-To: <3d93e748eb068963a9378b454ba9cd117cbbc737.1268669236.git.mika.westerberg@iki.fi>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<774b9c08b6e9484a2ca5084b8b6019aa18dddd99.1268669236.git.mika.westerberg@iki.fi>
	<3d93e748eb068963a9378b454ba9cd117cbbc737.1268669236.git.mika.westerberg@iki.fi>
Message-ID: <56d259a01003151244l352eeb50p95e97912b3df159a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mika, thanks, great work

On 3/15/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> Added a new function: ep93xx_chip_revision() which reads chip revision from the
>  sysconfig register.
>
>  + * %EP93XX_CHIP_REV_D0
>  + * %EP93XX_CHIP_REV_D1
>  + * %EP93XX_CHIP_REV_E0
>  + * %EP93XX_CHIP_REV_E1
>  + * %EP93XX_CHIP_REV_E2
>  + *
>  + * and in future maybe something else. See also <mach/platform.h>.

There will be no future revisions, if that's what you mean. Cirrus
dropped out of the ARM business and discontinued development of this
product line on 1st April 2008 so E2 is the last.

   M
