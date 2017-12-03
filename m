From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Dec 2017 09:12:37 -0200
Subject: [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
In-Reply-To: <8e295c61-089e-170d-bca2-42ded2021c99@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
 <20171201224425.5477-2-peda@axentia.se>
 <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
 <8e295c61-089e-170d-bca2-42ded2021c99@axentia.se>
Message-ID: <CAOMZO5AE++an6MnagrWoL4qwkDJaqtg_qJ5UKX3PB7sw1cTeiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Sun, Dec 3, 2017 at 4:59 AM, Peter Rosin <peda@axentia.se> wrote:

> Right. However, the patch adding that should have been sent to me, the
> maintainer of the driver. That is carefully recorded in MAINTAINERS. So,
> forgive me for assuming that nothing had changed in the driver behind my
> back.
>
> Had that patch been sent my way as it should have been, I would have
> insisted that maintenance of the bindings had been kept together with
> the maintenance of the driver.

When I sent this patch ./scripts/get_maintainer.pl did lot list your
name, so that's why I did not put you on Cc, sorry.

4.15-rc1 still does not list you, but linux-next does.

Would you like me to send the following patch so that new binding
updates go to you?

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9808,6 +9808,7 @@ NXP TFA9879 DRIVER
 M:     Peter Rosin <peda@axentia.se>
 L:     alsa-devel at alsa-project.org (moderated for non-subscribers)
 S:     Maintained
+F:     Documentation/devicetree/bindings/sound/tfa9879.txt
 F:     sound/soc/codecs/tfa9879*
