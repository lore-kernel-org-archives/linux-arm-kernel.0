From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 May 2018 16:22:02 +0530
Subject: [PATCH V3] ARM: dts: da850-evm: add WP and CD to MMC
In-Reply-To: <20180512122358.17459-1-aford173@gmail.com>
References: <20180512122358.17459-1-aford173@gmail.com>
Message-ID: <31cccaa0-21ea-3c03-dbc5-117f7b81e4e5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 May 2018 05:53 PM, Adam Ford wrote:
> The legacy mode uses the write protect and card detect but DT does not.
> This patch enables Write-Protect and Card-Detect pins for the MMC card, and
> the gpio-ranges property sets the gpio pinmuxing for those respective pins.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied to v4.18/dt.

Thanks,
Sekhar
