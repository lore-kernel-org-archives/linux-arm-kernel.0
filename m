From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 2 Dec 2017 19:17:47 -0200
Subject: [alsa-devel] [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
In-Reply-To: <20171201224425.5477-2-peda@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
 <20171201224425.5477-2-peda@axentia.se>
Message-ID: <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 8:44 PM, Peter Rosin <peda@axentia.se> wrote:
> Add record for NXP TFA9879 Mono BTL Class D audio amplifier.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> index af284fbd4d23..4cf30ce4e71f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> @@ -157,6 +157,7 @@ nxp,pcf2127         Real-time clock
>  nxp,pcf2129            Real-time clock
>  nxp,pcf8563            Real-time clock/calendar
>  nxp,pcf85063           Tiny Real-Time Clock
> +nxp,tfa9879            Mono BTL Class D audio amplifier

This is already described at Documentation/devicetree/bindings/sound/tfa9879.txt
