From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2018 21:55:54 -0300
Subject: [PATCH 1/3] ARM: i.MX31: remove rnga registration as a platform
 device
In-Reply-To: <20180703192934.6080-2-vz@mleia.com>
References: <20180703192934.6080-1-vz@mleia.com>
 <20180703192934.6080-2-vz@mleia.com>
Message-ID: <CAOMZO5ByGiOwEX2RNedqKmmhpqFMYuLuoVwEnS3jV4WWAppe7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2018 at 4:29 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> On i.MX31 powered boards with OF support Security Random Number
> Generator Accelerator RNGA controller is initialized from device tree,
> its registration as a platform device is redundant and actually it is
> broken due to missing clock information:
>
>   mxc_rnga mxc_rnga: Could not get rng_clk!
>   mxc_rnga: probe of mxc_rnga failed with error -2
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
