From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Oct 2012 19:30:33 +0900
Subject: [PATCH] ARM: EXYNOS: Remove wrong I2S0 clock from peril clock
In-Reply-To: <016501cda4fa$caa62dc0$5ff28940$@com>
References: <004d01cda2cc$37254570$a56fd050$@samsung.com>
 <016501cda4fa$caa62dc0$5ff28940$@com>
Message-ID: <01ab01cdb109$6f00d540$4d027fc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> On Friday, Oct 05, 2012 at 4:37 PM, Sangsu Park wrote:
> > Remove I2S0 clk from peril since peril clock doesn't have I2S0 clk for
> EXYNOS4.
> > Audio Subsystem block has I2S0 clk.
> >
> > Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> 
> Peril control bit 19 is reserved.
> 
> Acked-by: Sangbeom Kim <sbkim73@samsung.com>
> 
Applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
