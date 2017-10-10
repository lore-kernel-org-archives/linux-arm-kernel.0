From: robh@kernel.org (Rob Herring)
Date: Tue, 10 Oct 2017 13:33:58 -0500
Subject: [PATCH v3 05/12] pinctrl: axp209: add support for AXP813 GPIOs
In-Reply-To: <20171002120854.5212-6-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-6-quentin.schulz@free-electrons.com>
Message-ID: <20171010183358.e33h2lopppwdhncv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 02:08:47PM +0200, Quentin Schulz wrote:
> The AXP813 has only two GPIOs. GPIO0 can either be used as a GPIO, an
> LDO regulator or an ADC. GPIO1 can be used either as a GPIO or an LDO
> regulator.
> 
> Moreover, the status bit of the GPIOs when in input mode is not offset
> by 4 unlike the AXP209.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-axp209.txt | 13 ++++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/pinctrl-axp209.c                   | 32 ++++++++++++++++------
>  2 files changed, 36 insertions(+), 9 deletions(-)
