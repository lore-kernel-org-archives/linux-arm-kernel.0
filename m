From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 4 Nov 2014 08:30:24 -0200
Subject: [PATCH] ARM: imx: Explicitly select CONFIG_SPI
In-Reply-To: <20141104081645.GJ10821@tiger>
References: <1414617568-27615-1-git-send-email-festevam@gmail.com>
 <20141103062606.GF10821@tiger>
 <CAOMZO5AB8khWKYmeOQWd0_jT4Ho0ogAkUX+=3mfhqEVhhxeqGQ@mail.gmail.com>
 <20141104081645.GJ10821@tiger>
Message-ID: <CAOMZO5CdXt64VsmteP4Q-8C_7+PKHVSPeNLd8g5jexORYD1HhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 4, 2014 at 6:16 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The CONFIG_SPI was removed by your commit 64546e9fe3a5 (ARM:
> imx_v6_v7_defconfig updates), which cames from savedefconfig, I assume.
> That said, in the code base that your patch was generated, option
> CONFIG_SPI is redundant, But it's not the case on mainline.

Ops, sorry about that. That's correct. I have just sent v2 and pointed
out the faulty commits.

Thanks
