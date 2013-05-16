From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 May 2013 07:58:03 +0100
Subject: [PATCH 35/39] dmaengine: ste_dma40_ll: Replace meaningless
 register set with comment
In-Reply-To: <20130516051820.GH27639@intel.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-36-git-send-email-lee.jones@linaro.org>
 <20130516051820.GH27639@intel.com>
Message-ID: <20130516065803.GB3269@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Unsure of the author's intentions, rather than just removing the nop,
> > we're replacing it with a comment containing the possible intention
> > of the statement OR:ing with 0.
> Would be worthwhile to check w/ Linus W on this (or check whom to blame)

I did already. It was his idea to place the comment in.

The original author will on parental leave for the foreseeable future.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
