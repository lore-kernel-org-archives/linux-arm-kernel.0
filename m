From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 3 Apr 2013 20:16:18 +0000 (UTC)
Subject: [PATCH] OMAP/serial: Revert bad fix of Rx FIFO threshold
 granularity
In-Reply-To: <20130403183146.GA4072@inertiallabs-linux64>
References: <20130403183146.GA4072@inertiallabs-linux64>
Message-ID: <alpine.DEB.2.00.1304032015050.16711@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, Alexey,

On Wed, 3 Apr 2013, Alexey Pelykh wrote:

> From: Alexey Pelykh <alexey.pelykh@gmail.com>
> 
> Partially reverts 1776fd059c40907297d6c26c51876575d63fd9e2
> that introduced regression reported by Paul Walmsley.
> 
> This commit restores setting granularity in SCR register
> and adds note about comments below being inconsistent with
> actual code.
> 
> Signed-off-by: Alexey Pelykh <alexey.pelykh@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-serial at vger.kernel.org 
> Cc: linux-arm-kernel at lists.infradead.org 
> Cc: linux-omap at vger.kernel.org 

Tested-by: Paul Walmsley <paul@pwsan.com>

Thanks for the fast response and fix, Alexey.

Greg, is it possible for you to take this for v3.9-rc fixes?


- Paul
