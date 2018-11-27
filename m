From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Nov 2018 01:11:18 +0100
Subject: [PATCH v2 2/4] ARM: dts: rockchip: Assign the proper GPIO clocks
 for rv1108
In-Reply-To: <20181126173506.24068-2-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
 <20181126173506.24068-2-otavio@ossystems.com.br>
Message-ID: <2518848.VcqGXKeQUg@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. November 2018, 18:35:04 CET schrieb Otavio Salvador:
> It is not correct to assign the 24MHz clock oscillator to the GPIO
> ports.
> 
> Fix it by assigning the proper GPIO clocks instead.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>

applied for 4.21

Thanks
Heiko
