From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 8 Oct 2015 15:43:59 +0000
Subject: [PATCH v2 3/9] dmaengine: st_fdma:  Add STMicroelectronics FDMA
 driver header file
In-Reply-To: <1441980871-24475-4-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <1444118413.3579.46.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-11 at 15:14 +0100, Peter Griffin wrote:

> +#define FDMA_ID_OFST		0x00000
> +#define FDMA_VER_OFST		0x00004
> > +
> +#define FDMA_EN_OFST		0x00008

Why cant these be BIT() to maintain consistency?

-- 
~Vinod
