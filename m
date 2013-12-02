From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Dec 2013 14:03:24 +0000
Subject: [alsa-devel] [PATCH 07/10] ASoC: ux500: Store DMA data in the
 DAI differently in the pdata and DT case
In-Reply-To: <20131202135452.GI27568@sirena.org.uk>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
 <CAOesGMiu16f_L=cMWFCNZMjNB9tBK-2LXn02k-R7FhkkgR5-+g@mail.gmail.com>
 <20131202101256.GA29373@lee--X1>
 <20131202135452.GI27568@sirena.org.uk>
Message-ID: <20131202140324.GH31626@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Dec 2013, Mark Brown wrote:

> On Mon, Dec 02, 2013 at 10:12:56AM +0000, Lee Jones wrote:
> 
> > It's actually my fault. I had two patches round the wrong way in the
> > series. The imediately subsequent patch in the set fixes this issue:
> 
> OK, so what do we do about this?  Is there going to be a revision of
> that patch adding the note about not using the autoconfiguration stuff
> and what (if any) are the dependencies on the arch/arm changes?

I can shoot out a revision no problem.

I'm not aware of any dependencies on the ARM changes. I haven't tested
the arch/arm and sound/soc adaptions orthogonally, but I _think_ the
right decisions should be made depending on the information passed
from platform/dt code.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
