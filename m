From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Jun 2013 10:54:11 -0300
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <20130624072908.GH26254@S2101-09.ap.freescale.net>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
 <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
 <201306221524.33879.marex@denx.de>
 <CAOMZO5DYNmiasRREC8jXH===2HG1aNvpxpFVU2u+q5ZAT8Wd3Q@mail.gmail.com>
 <20130624072908.GH26254@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Bfetjwinatj4W-nrEvg+3pLfjgF8Zpx_-=n52ZTGHeGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 4:29 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Yes, we should have sgtl5000 acquire its clock, but when it fails to do
> so, there is nothing wrong with deferring it to see if mxs-saif would
> provide the clock later.

I didn't manage to get mx28evk to probe audio correctly by using -EPROBE_DEFER.
