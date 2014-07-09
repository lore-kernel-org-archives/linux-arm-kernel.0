From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 9 Jul 2014 13:59:34 +0100
Subject: [PATCH v3 01/10] mmc: sdhci-st: Intial support for ST SDHCI
 controller
In-Reply-To: <CAPDyKFoFNaFpDTVvMF3fbkrgYwUY1_hcbic89JyJzezFDRtN_w@mail.gmail.com>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
 <1401899424-1365-2-git-send-email-peter.griffin@linaro.org>
 <CAPDyKFoFNaFpDTVvMF3fbkrgYwUY1_hcbic89JyJzezFDRtN_w@mail.gmail.com>
Message-ID: <20140709125934.GA18634@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, 09 Jul 2014, Ulf Hansson wrote:

> On 4 June 2014 18:30, Peter Griffin <peter.griffin@linaro.org> wrote:
> > This platform driver adds initial support for the SDHCI host controller
> > found on STMicroelectronics SoCs.
> >
> > It has been tested on STiH41x b2020 platforms currently.
> >
> > Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> 
> Thanks! Applied for next.

Can you drop this patch for the moment?

I was just rebasing the series for Maxime, and noticed this patch needs a few 
fixups to cope with Russell Kings recent changes in sdhci.c.

regards,

Peter.
