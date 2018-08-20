From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 20 Aug 2018 07:41:22 -0600
Subject: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
In-Reply-To: <20180820111755.rzg7l2lznmbpuf2e@flea>
References: <20180804070355.14857-1-manu@freebsd.org>
 <20180820111755.rzg7l2lznmbpuf2e@flea>
Message-ID: <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > This patch adds documentation for Device-Tree bindings for the Allwinner
> > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> >
> > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
>
> I'm not going to merge a binding for a device that doesn't have any
> driver implemented at the moment in Linux.

I'll take it then. Linux is not the only DT client.

Rob
