From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Apr 2012 09:34:31 -0600 (MDT)
Subject: [PATCH v2 2/2] ARM: omap: hwmod: Make omap_hwmod_softreset wait
 for reset status
In-Reply-To: <1331647435-31666-3-git-send-email-rnayak@ti.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com>
 <1331647435-31666-3-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1204040934210.8000@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Mar 2012, Rajendra Nayak wrote:

> omap_hwmod_softreset() does not seem to wait for reset status
> after doing a softreset. Make it use _ocp_softreset() instead
> which does this correctly.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Anand Gadiyar <gadiyar@ti.com>
> Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.4-rc.


- Paul
