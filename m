From: ljkenny@gmail.com (Lee Jones)
Date: Thu, 20 Sep 2012 09:32:18 +0200
Subject: Pull request question for Mark (ASoC)
Message-ID: <20120920073218.GA10230@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

I have a pull request for you, but at least one of the patches
touches the MOP500 driver as well as ux500 platform code. If I
split them up into for-asoc-next and for-arm-soc-next branches
there I it will cause conflicts in arch/arm/mach-ux500/*. 

Is it okay to send the 6 patches I have for ASoC, all of which
are encapsulated in sound/soc/ux500/ through the arm-soc tree
with the rest of my patches please?

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
