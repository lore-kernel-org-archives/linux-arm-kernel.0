From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Jun 2016 08:26:38 -0500
Subject: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160606132638.GA17368@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
> The usb power-supply on the axp22x pmics is mostly identical to the
> one on the axp20x pmics. One significant difference is that it cannot
> measure / monitor the usb voltage / current.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use compatible instead of axp20x->variant to detect pmic type
> ---
>  .../bindings/power_supply/axp20x_usb_power.txt     |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/axp20x_usb_power.c                   | 92 ++++++++++++++++------
>  2 files changed, 71 insertions(+), 24 deletions(-)
