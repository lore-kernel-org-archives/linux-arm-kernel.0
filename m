From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 6 Mar 2017 18:46:24 -0300
Subject: [PATCH 1/2] drm/bridge: ti-tfp410: support hpd via gpio
In-Reply-To: <2e47786ab3d04078ae70d0c4064f7c4d@rwthex-s1-b.rwth-ad.de>
References: <2e47786ab3d04078ae70d0c4064f7c4d@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5C90EVY1oyhMu8Ahm++YeVq_qE1x6RwzB6hxKJZEuL10Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Mon, Mar 6, 2017 at 6:40 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>
> On some boards the hpd pin of a hdmi connector is wired up to a gpio
> pin. Since in the DRM world the tfp410 driver is responsible for
> handling the connector, add support for hpd gpios in this very driver.
>
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> ---
>  drivers/gpu/drm/bridge/ti-tfp410.c | 72 ++++++++++++++++++++++++++++++++++++--

It would be nice to add 'hpd-gpios' property in the binding doc as well:
Documentation/devicetree/bindings/display/bridge/ti,tfp410.txt
