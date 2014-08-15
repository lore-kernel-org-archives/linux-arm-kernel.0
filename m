From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 15 Aug 2014 14:05:50 +0100
Subject: [PATCH v2] mmc: sdhci-pxav3: set_uhs_signaling is initialized
 twice differently
In-Reply-To: <1408107342-20318-1-git-send-email-peter.griffin@linaro.org>
References: <1408107342-20318-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140815130550.GA20932@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> This means that uhs is currently broken for this platform currently, as pxav3
> has some special constriants which means it can't use the generic callback.
> 
> This happened in
> commit 96d7b78cfc2f ("mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function")
> commit a702c8abb2a9 ("mmc: host: split up sdhci-pxa, create sdhci-pxav3.c")'
> 
> Fix this and hopefully prevent it happening in the future by ensuring named
> initialisers always follow the declaration order in the structure definition.

Or it would if I actually committed the change. Sorry for the noise, please ignore this patch.
I've just sent a V3.

regards,

Peter.
