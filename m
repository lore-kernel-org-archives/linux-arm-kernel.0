From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 1 May 2017 13:30:19 +0200
Subject: [PATCH v6 2/6] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
In-Reply-To: <20170418073421.31351-3-quentin.schulz@free-electrons.com>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
 <20170418073421.31351-3-quentin.schulz@free-electrons.com>
Message-ID: <20170501113019.gc4mblrwvyd7qgv3@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 18, 2017 at 09:34:17AM +0200, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
> 
> This patch adds the battery power supply driver to get various data from
> the PMIC, such as the battery status (charging, discharging, full,
> dead), current max limit, current current, battery capacity (in
> percentage), voltage max and min limits, current voltage and battery
> capacity (in Ah).
> 
> This battery driver uses the AXP20X/AXP22X ADC driver as PMIC data
> provider.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Sebastian Reichel <sre@kernel.org>

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170501/9eedd794/attachment.sig>
