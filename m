From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 29 Sep 2015 10:24:42 +0100
Subject: [PATCH v2 2/9] dmaengine: st_fdma: Add st fdma platform specific
 header
In-Reply-To: <2654563.3IzPKrUkAU@wuerfel>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-3-git-send-email-peter.griffin@linaro.org>
 <2654563.3IzPKrUkAU@wuerfel>
Message-ID: <20150929092442.GB16955@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, 11 Sep 2015, Arnd Bergmann wrote:

> On Friday 11 September 2015 15:14:24 Peter Griffin wrote:
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  include/linux/platform_data/dma-st_fdma.h | 72 +++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >  create mode 100644 include/linux/platform_data/dma-st_fdma.h
> > 
> 
> This clearly needs an explanation of which platforms require the header.
> 
> On ARM, all new platforms use DT, so it's obviously not one of them.

I will move the relevant parts into the st_fdma.h header file, as no other platforms
will be upstreamed that are not DT based.

regards,

Peter.
