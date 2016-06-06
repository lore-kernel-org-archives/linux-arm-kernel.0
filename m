From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 6 Jun 2016 16:09:01 +0100
Subject: [PATCH 00/18]  Add support for FDMA DMA controller and xp70
 rproc found on STi chipsets
In-Reply-To: <20160606050148.GX16910@localhost>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <20160606050148.GX16910@localhost>
Message-ID: <20160606150901.GH9912@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, 06 Jun 2016, Vinod Koul wrote:

> On Wed, May 25, 2016 at 05:06:33PM +0100, Peter Griffin wrote:
> > 
> > Peter Griffin (18):
> >   dmaengine: st_fdma: Add STMicroelectronics FDMA DT binding
> >     documentation
> >   dmaengine: st_fdma:  Add STMicroelectronics FDMA driver header file
> >   dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support
> >   dmaengine: st_fdma: Add xp70 firmware loading mechanism.
> >   dmaengine: st_fdma: Add fdma suspend and resume callbacks.
> 
> I do not see the latter two patches in this series. Something is missed here
> from cover to actual patches which is bit bizarre as one tends to generate
> patches and cover together

Sorry I accidentally sent two cover letters as part of this series. The v4
one is here https://lkml.org/lkml/2016/5/25/451.

regards,

Peter.
