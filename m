From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Sep 2016 16:50:34 +0200
Subject: [PATCH v5 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <1473344917-1524-4-git-send-email-quentin.schulz@free-electrons.com>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-4-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160909145034.GE8881@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 04:28:37PM +0200, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
> 
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree. This registers
> the driver in the thermal framework.
> 
> This driver probes on three different platform_device_id to take into
> account slight differences (registers bit and temperature computation)
> between Allwinner SoCs ADCs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/f5011934/attachment.sig>
