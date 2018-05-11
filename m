From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 10 May 2018 21:37:19 -0300
Subject: [PATCH 2/3] ARM: dts: imx28: Remove unit-address from pinctrl
In-Reply-To: <1525997810-10964-2-git-send-email-festevam@gmail.com>
References: <1525997810-10964-1-git-send-email-festevam@gmail.com>
 <1525997810-10964-2-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5D9XguGVTV7GHYWTPPQ-whiQTTtL0ZVt6qV0R_ojyu89Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, May 10, 2018 at 9:16 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Remove unit-address and reg property from pinctrl subnodes to fix
> the following DTC warnings with W=1:
>
> arch/arm/boot/dts/imx28-apf28dev.dtb: Warning (unique_unit_address): /apb at 80000000/apbh at 80000000/pinctrl at 80018000/hog at 0: duplicate unit-address (also used in node /apb at 80000000/apbh at 80000000
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Please discard this one and 3/3 for now.

I noticed that audio is no longer functional after this change. I will debug it.
