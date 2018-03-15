From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 15 Mar 2018 00:21:02 -0500
Subject: [PATCH v2] ARM: dts: msm8974: castor: Fix typo and add startup
 delay in touchscreen node
In-Reply-To: <20180313164638.7211-1-ctatlor97@gmail.com>
References: <20180312160734.5606-1-ctatlor97@gmail.com>
 <20180313164638.7211-1-ctatlor97@gmail.com>
Message-ID: <20180315051936.GC5910@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 04:46:38PM +0000, Craig Tatlor wrote:
> The compatible string was mistakenly pulled from the downstream tree and the
> startup delay property is needed to prevent io errors on initial page select.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Thanks for the patch.  I'll add Bjorn's reviewed-by and apply it.

Regards,
Andy
