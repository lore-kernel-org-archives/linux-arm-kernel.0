From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 16 Dec 2017 18:17:39 +0100
Subject: [PATCH 0/3] arm64: dts: Support Mali450 on rk3328
In-Reply-To: <20171209000738.32187-1-heiko@sntech.de>
References: <20171209000738.32187-1-heiko@sntech.de>
Message-ID: <1545865.1tkaHIZnpa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 9. Dezember 2017, 01:07:35 CET schrieb Heiko Stuebner:
> Pretty standard setup. Tested with the kmscube demo running
> using the lima kernel and gallium driver.
> 
> 
> Heiko Stuebner (3):
>   dt-bindings: gpu: mali-utgard: add rockchip,rk3328-mali compatible
>   arm64: dts: rockchip: add rk3328 mali gpu node
>   arm64: dts: rockchip: enable gpu on rk3328-rock64

applied for 4.16 with Robs review and following his suggestion
of making the gpu simply always-on and thus droppping patch 3.
