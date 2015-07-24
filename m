From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 24 Jul 2015 16:59:28 +0200
Subject: [PATCH v3 1/4] ARM: dts: Add binding documentation for AXP20x
 pmic usb power supply
In-Reply-To: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150724145928.GG27569@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 26, 2015 at 12:59:14PM +0200, Hans de Goede wrote:
> Add binding documentation for the usb power supply part of the AXP20x pmic.
> [...]
> +Example:
> +
> [...]
> +
> +	usb_power_supply: usb_power_supply {
                      ^^^^^^^^^^^^^^^^
                      use usb-power-supply here.
> +		compatible = "x-powers,axp202-usb-power-supply";
> +	};
> +};

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/45a5f13f/attachment.sig>
