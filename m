From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 20 Feb 2018 07:40:36 -0600
Subject: [PATCH v5 2/5] dt-bindings: gpio: add raspberry pi GPIO expander
 binding
In-Reply-To: <f400b48cbcd8a138c39d4e8f63d6c1f569090dcc.1519128054.git.baruch@tkos.co.il>
References: <cover.1519128054.git.baruch@tkos.co.il>
 <f400b48cbcd8a138c39d4e8f63d6c1f569090dcc.1519128054.git.baruch@tkos.co.il>
Message-ID: <CAL_JsqJW43q1rmSKa4joNj7=XpFScts2prXsHSpUjWWj3fOPdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 6:19 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> The Raspberry Pi 3 GPIO expander is controlled by the VC4 firmware over
> I2C. The firmware mailbox interface allows the ARM core to control the
> GPIO lines.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v5:
>   * Remove the 'firmware' property
>   * Note that the gpio node is a child of the firmware node
>
> v4:
>   * Move the example gpio node under the firmware node
>   * Rename gpio node name to plain 'gpio'
>
> v3:
>   * Rename node name.
>
> v2:
>   * Rename compatible string to raspberrypi,firmware-gpio
> ---
>  .../bindings/gpio/raspberrypi,firmware-gpio.txt    | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,firmware-gpio.txt

Reviewed-by: Rob Herring <robh@kernel.org>
