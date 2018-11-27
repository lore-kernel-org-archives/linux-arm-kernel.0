From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 27 Nov 2018 01:12:05 +0100
Subject: [PATCH v2 3/4] ARM: dts: rockchip: Add UART DMA support for rv1108
In-Reply-To: <20181126173506.24068-3-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
 <20181126173506.24068-3-otavio@ossystems.com.br>
Message-ID: <2153234.84VALTjZKd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. November 2018, 18:35:05 CET schrieb Otavio Salvador:
> Pass the 'dmas' property to the UART ports so that DMA can
> be supported.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>

applied for 4.21 after moving the dma-* below the clock*
alphabetical ordering and such :-)

Thanks
Heiko
