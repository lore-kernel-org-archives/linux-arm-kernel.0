From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Jul 2013 14:07:50 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabresd: Add touchscreen support
In-Reply-To: <1374615677-18437-1-git-send-email-festevam@gmail.com>
References: <1374615677-18437-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5Abj46xhabJGwm9C9EcsCSrPWs-FSFb4R+bwvKGKjx-Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 6:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> mx6 sabresd boards have a egalax touchscreen controller connected via i2c2.
>
> Add support for it.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Hi Shawn,
>
> I don't have access to a sabresd board at the moment, so could not test this.

Ok, I got a sabresd now and I realized that max11801 driver is also
needed, so will work on it when time permits.

Regards,

Fabio Estevam
