From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 21 Nov 2014 17:38:44 +0000 (UTC)
Subject: [PATCH v3 1/2] ARM: OMAP2+: hwmod: AM43x: add hwmod support for
 ADC on AM43xx
In-Reply-To: <1416564862-23056-2-git-send-email-vigneshr@ti.com>
References: <1416564862-23056-1-git-send-email-vigneshr@ti.com>
 <1416564862-23056-2-git-send-email-vigneshr@ti.com>
Message-ID: <alpine.DEB.2.02.1411211737100.9204@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Nov 2014, Vignesh R wrote:

> This patch adds hwmod support for ADC on AM43xx. Since clockdomain
> and offsets of adc_tsc are different from AM33xx, ADC data has been
> directly added to AM43xx hwmod file.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Thanks, will try to queue this for v3.19.  Will update my previous pull 
request.  Otherwise it's v3.20 material.

Note that I cannot test this patch locally due to the lack of an AM43xx 
board.


- Paul
