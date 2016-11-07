From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 07 Nov 2016 11:51:20 +0900
Subject: [PATCH RFC 3/7] spi: s3c64xx: Do not use platform_data for DMA
 parameters
In-Reply-To: <1478276094-19135-5-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <CGME20161104161715epcas5p16e5794ae9564f5bc5d899e874ceebfc9@epcas5p1.samsung.com>
 <1478276094-19135-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161107025120.o7ubznfooidktix6@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

> All related platforms use either devicetree or the DMA slave
> map API for mapping DMA channels to DMA slaves so we can now
> stop using platform_data for passing DMA details.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Tested-by: Andi Shyti <andi.shyti@samsung.com>

Andi
