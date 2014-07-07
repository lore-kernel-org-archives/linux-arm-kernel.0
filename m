From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 16:26:36 +0200
Subject: [PATCH v5 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <53B18A87.7040305@wwwdotorg.org>
References: <1403177830-28595-1-git-send-email-thierry.reding@gmail.com>
 <1403177830-28595-2-git-send-email-thierry.reding@gmail.com>
 <53B18A87.7040305@wwwdotorg.org>
Message-ID: <CACRpkdae+LSfhEN9KZDeGYxcK8OkmqtHBb=uUxgBrpJmEWnaug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 6:04 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/19/2014 05:37 AM, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The XUSB pad controller found on NVIDIA Tegra SoCs provides several pads
>> that lanes can be assigned to in order to support a variety of interface
>> options: USB 2.0, USB 3.0, PCIe and SATA.
>>
>> In addition to the pin controller used to assign lanes to pads two PHYs
>> are exposed to allow the bricks for PCIe and SATA to be powered up and
>> down by PCIe and SATA drivers.
>
> Linus, does the driver look OK? I'm hoping for an ack from you so that I
> can take this series through the Tegra tree to resolve some
> dependencies; we have various other drivers that depend on this series.

Sure thing, if it looks OK to you, by all means apply it yo your tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

(Also goes for the DT bindings FWIW)

Yours,
Linus Walleij
