From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 11:17:09 -0500
Subject: [PATCH v2] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for
 Bluetooth
In-Reply-To: <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
 <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <CAL_JsqK4qwipnhhT=n3-sqh1rRXU4McJjR6WEAp+Tvnjvb5osw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2018 at 7:16 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>

ttyAML1 has nothing to do with dts files.

> This change adds the uart_A used by the brmcfmac sdio module in the
> WeTek Hub and WeTek Play 2 devices. meson_uart_probe seems to mandate
> an alias (without it, BT is not working) so this is also included.

You should fix the alias being required. It should not be.

> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
