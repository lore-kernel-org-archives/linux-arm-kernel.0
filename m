From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2016 15:05:42 +0000
Subject: [PATCH v5 2/2] ACPI: amba bus probing support
In-Reply-To: <1452518790-27053-3-git-send-email-aleksey.makarov@linaro.org>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
 <1452518790-27053-3-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <20160111150541.GT19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 07:26:27PM +0600, Aleksey Makarov wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> On ARM64 some devices use the AMBA device and not the platform bus for
> probing so add support for this. Uses a dummy clock for apb_pclk as ACPI
> does not have a suitable clock representation and to keep the core
> AMBA bus code unchanged between probing methods.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

This looks fine to me, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
