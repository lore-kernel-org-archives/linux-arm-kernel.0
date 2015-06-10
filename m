From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 10 Jun 2015 16:46:48 +0200
Subject: [PATCH 1/2] power_supply: max17042: Add OF support for setting
 thresholds
In-Reply-To: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
References: <1433725899-13849-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150610144648.GC11618@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 08, 2015 at 10:11:38AM +0900, Krzysztof Kozlowski wrote:
> The commit edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_*
> properties support") added support for setting voltage and temperature
> thresholds with platform data. For DeviceTree default of 0 was always
> used.
> 
> This caused reporting battery health always as over voltage or
> over heated.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_* properties support")

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150610/12618830/attachment.sig>
