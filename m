From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 17:56:56 +0800
Subject: [PATCH 04/10] power: supply: axp20x_usb_power: add 100mA max
 current limit for AXP223
In-Reply-To: <20161125090921.23138-5-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-5-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v66WZCR3afRk6e03gs4RqUPbV4ixb_6=T3=qSMWgcscX3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP223 shares most of its behaviour with the AXP221 PMIC
> but allows the VBUS power supply max current to be set to 100mA (like
> the AXP209 PMIC).
>
> This basically adds a new compatible to the VBUS power supply driver and
> adds a check on the compatible when setting current max limit.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
