From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 13 Oct 2015 11:43:01 +0100
Subject: [PATCH v2 3/9] dmaengine: st_fdma:  Add STMicroelectronics FDMA
 driver header file
In-Reply-To: <1444118413.3579.46.camel@intel.com>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-4-git-send-email-peter.griffin@linaro.org>
 <1444118413.3579.46.camel@intel.com>
Message-ID: <20151013104301.GA30342@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 08 Oct 2015, Koul, Vinod wrote:

> On Fri, 2015-09-11 at 15:14 +0100, Peter Griffin wrote:
> 
> > +#define FDMA_ID_OFST		0x00000
> > +#define FDMA_VER_OFST		0x00004
> > > +
> > +#define FDMA_EN_OFST		0x00008
> 
> Why cant these be BIT() to maintain consistency?
> 

These are actually register offsets. I'm only using the BIT
macro for bitfields within the registers e.g. FDMA_EN_RUN

regards,

Peter.
