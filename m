From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Nov 2018 15:03:12 +0100
Subject: [PATCH] arm64: dts: rockchip: Fix PCIe reset polarity for
 rk3399-puma-haikou.
In-Reply-To: <20181113102535.444-1-christoph.muellner@theobroma-systems.com>
References: <20181113102535.444-1-christoph.muellner@theobroma-systems.com>
Message-ID: <1558970.1d7cp66mMg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

Am Dienstag, 13. November 2018, 11:25:35 CET schrieb Christoph Muellner:
> This patch fixes the wrong polarity setting for the PCIe host driver's
> pre-reset pin for rk3399-puma-haikou. Without this patch link training
> will most likely fail.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>

I've added a Fixes-tag pointing to the original commit and applied
it as fix for 4.20

Thanks
Heiko
