From: B04825@freescale.com (Tabi Timur-B04825)
Date: Wed, 14 Mar 2012 02:57:00 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120313234638.GY3177@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
Message-ID: <4F6008FA.3040805@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:

> With this card those would just be separate CODECs.  This is a binding
> for a simple card.

But that is insufficient for the SSI driver, which is expected to handle 
multiple SSIs.  If you're going to document a binding for the SSI driver, 
then you need to document how to handle multiple SSIs.

> The biggest improvement is that the SoC binding knows nothing about the
> card binding at all, cards are completely separate and are free to
> define any binding they choose using any number of on-SoC and off-SoC
> devices.

Ok, I don't understand that at all.

I also don't understand why you insist on perverting my driver to support 
two incompatible bindings, especially since I still haven't heard an 
explanation as to what's wrong with the binding that I defined.

-- 
Timur Tabi
Linux kernel developer at Freescale
