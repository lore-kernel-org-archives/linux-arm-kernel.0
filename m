From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 16:33:47 +0530
Subject: [PATCH V2] ARM: dts: da850-evm: add WP and CD to MMC
In-Reply-To: <20180427022409.13105-1-aford173@gmail.com>
References: <20180427022409.13105-1-aford173@gmail.com>
Message-ID: <ecbbf439-b096-d26a-e574-a23956628249@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2018 07:54 AM, Adam Ford wrote:
> The legacy mode uses the write protect and card detect but DT
> has not.  This patch enables the pinmuxing and detection for
> WP and CD.

patch description should be readable without reference to headline. So
"MMC" should appear somewhere in the description too. Also, you are not
doing pinmuxing anymore. I think the reference to that should be dropped
or refer to the fact that this happening through gpio-ranges property.

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks,
Sekhar
