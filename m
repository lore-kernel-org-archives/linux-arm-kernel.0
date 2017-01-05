From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 17:40:47 +0100
Subject: [PATCH 01/22] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT
 binding
In-Reply-To: <20170102163723.7939-2-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-2-quentin.schulz@free-electrons.com>
Message-ID: <20170105164047.ksaww7punkcyrl2t@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 05:37:01PM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> battery voltage, battery charge and discharge currents, AC-in and VBUS
> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
> 
> This adds the device tree binding documentation for the X-Powers AXP20X
> and AXP22X PMICs ADCs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/cd9e296a/attachment.sig>
