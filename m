From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 10:29:02 +0100
Subject: [PATCH 12/13] ARM: dts: rv1108: Pass the 'arm,
 cpu-registers-not-fw-configured' property
In-Reply-To: <20181125211907.9895-12-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-12-otavio@ossystems.com.br>
Message-ID: <21161698.dmfua2PuA8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 25. November 2018, 22:19:06 CET schrieb Otavio Salvador:
> Since firmware does not initialize  any of the generic timer CPU
> registers pass the 'arm,cpu-registers-not-fw-configured' property as
> suggested in Documentation/devicetree/bindings/timer/arm,arch_timer.txt.
> 
> This also aligns with other Rockchip SoC dtsi files.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied for 4.21 after adapting the subject a bit.


Thanks
Heiko
