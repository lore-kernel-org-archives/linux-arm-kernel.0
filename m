From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 15 Jul 2012 18:10:28 -0600 (MDT)
Subject: [PATCH] ARM: OMAP: hwmod: Disable module when hwmod enable fails
In-Reply-To: <1341580892-1028-1-git-send-email-rnayak@ti.com>
References: <1341580892-1028-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1207151810170.28834@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jul 2012, Rajendra Nayak wrote:

> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> Clock and module mode are explictly enable when hwmod is enabled. But if
> the hwmod doesn't get ready on time, clocks are disabled but module is left
> enabled.
> 
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>

Thanks, queued for 3.6-rc.

- Paul
