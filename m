From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 29 Jan 2017 17:21:54 +0100
Subject: [PATCH v2 03/25] power: supply: axp20x_usb_power: use IIO
 channels when available
In-Reply-To: <20170127085458.18270-4-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-4-quentin.schulz@free-electrons.com>
Message-ID: <20170129162154.pyqi4m5eo6jpaint@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2017 at 09:54:36AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X PMIC exposes the current current and voltage
> measures via an internal ADC.
> 
> This adds the possibility to read IIO channels directly for processed
> values rather than reading the registers and computing the value.
> 
> For backward compatibility purpose, if the IIO driver is not compiled,
> this driver will fall back on previous behaviour which is direct
> register readings.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

I queued this into power-supply's for next branch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/63470183/attachment.sig>
