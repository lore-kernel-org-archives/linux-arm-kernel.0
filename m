From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 21 Dec 2013 17:19:53 +0000
Subject: [PATCH 00/10] ASoC: ARM: ux500: Better prepare for full Device
 Tree
In-Reply-To: <20131221142959.GH30815@sirena.org.uk>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <20131221142959.GH30815@sirena.org.uk>
Message-ID: <20131221171953.GA7988@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > At this moment in time the Ux500 ASoC driver obtains its DMA information
> > via AUXDATA platform data passing. To make the driver more independent
> > we have to start extracting it from the Device Tree. This patch-set goes
> > some way to ensure the ux500 Audio driver is ready for the switch over.
> 
> This all looks good to me, I guess it's OK if I merge the ARM patch?

That would be up to Linus.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
